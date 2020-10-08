
######################################### start #######################################################
import json
import logging
from datetime import date

logging.basicConfig(filename="Transformer.log", filemode='w', format='%(name)s - %(levelname)s - %(message)s')

######################################### Transformation function #####################################
def JSON_Transformer(myData, json):
    try:
        for i in range(0, len(myData)):
            # looping through each object of the JSON file
            for (key, value) in myData[i].items():
                # looping through each dict values of each object
                if key not in ("_id", 'guid'): #id values must not be changed even though the type is string
                    if str(type(value)) == "<class 'str'>":
                        myData[i][key] = str(value)[::-1]
                    elif str(type(value)) in ("<class 'float'>", "<class 'int'>"):
                        myData[i][key] = value * 2
                if key == "tags":
                    # reversing each string of tags element of list
                    myData[i][key] = [item[::-1] for item in myData[i][key]]
                elif key == "friends":
                    # reversing each string value of friends element of dictionary inside the list
                    for dict1 in myData[i][key]:
                        dict1.update((k, v[::-1]) for k, v in dict1.items() if k == "name")
            file_name = "index_" + str(myData[i]["index"]) + "_json_.json"
            # invoking the file writer function
            File_generator(myData[i], file_name, json)
            # writing info log into the log file
    except:
        logging.error(str(date.today()) + " ERROR: Something went wrong when writing json file for index = " + str(myData[i]["index"]))
    finally:return

######################################### File generator function #####################################
def File_generator (transformed_data, target_file, json) :
    with open(target_file, 'w') as JSON_file:
        json.dump(transformed_data, JSON_file, indent=4)

######################################### Main Function ###############################################
def main(arg):
    try:
        # getting source file name from the parameter arg
        source_file = arg
        # reading the file
        file = open(source_file)
        # build new JSON object using the JSON library
        myData = json.load(file)
        file.close()
    except:
        logging.error(str(date.today()) + " ERROR: something went wrong when loading JSON file")
    finally:
        # calling the main transformation function
        JSON_Transformer(myData, json)

if __name__ == "__main__":
    # this following line will be used once we decided to run this code on the server or from the console with parameter
    #for arg in sys.argv[1:]:
    main('generated.json')


######################################### end ##########################################################

