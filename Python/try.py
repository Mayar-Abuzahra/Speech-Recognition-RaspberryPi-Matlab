import speech_recognition as sr
import pyaudio 
import lcddriver
import time
import statistics
import numpy as np 
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
from sklearn import preprocessing
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
from sklearn import neighbors
from sklearn import naive_bayes
from sklearn import tree
from sklearn import ensemble
from sklearn import svm
from sklearn import neural_network
from scipy.stats import skew,kurtosis
from sklearn.ensemble import RandomForestClassifier


lcd = lcddriver.lcd()
lcd.Print("    Welcome   ",1)
def speech_recog():
    r = sr.Recognizer()

    mic = sr.Microphone()
    while True:
        with mic as source:
            print("Speak...")
            lcd.Print("Speak",2)
            

            audio = r.record(source,duration=2)
            signal=audio
            #print(audio)
            
            df = pd.read_csv('dsp.csv')
            Xtrain = df[df.columns[:-1]].values
            ytrain = df[df.columns[-1]].values
            rand_forest = RandomForestClassifier()
            rand_forest.fit(Xtrain,ytrain)
            signal = np.random.normal(-1, 1, 100)
            array1 = np.array([np.mean(signal),np.std(signal),np.median(signal),skew(signal),kurtosis(signal)])#edit : proprities 
            #print(np.array([np.mean(signal),np.std(signal),np.median(signal),skew(signal),kurtosis(signal)]))
            xtest = np.reshape(array1, (-1, 5))
            y_pred = rand_forest.predict(xtest)
            #print(y_pred)


 
            try:
                text = r.recognize_google(audio)
                if text=='hi':
                 print("hi")
                 time.sleep(1) 
                 lcd.Print("You said : HI    ",2)
                 lcd.Print("Gender :"+str(y_pred),3)
                 lcd.Print("Thank You",4)
                 break
                elif text=='bye':
                 print("bye")
                 time.sleep(1) 
                 lcd.Print("You said : BYE   ",2)
                 lcd.Print(str(y_pred),3)
                 lcd.Print("Thank You",4)
                 break
                elif text=='hello':
                 print("Hello")
                 time.sleep(1) 
                 lcd.Print("You said : Hello   ",2)
                 lcd.Print(str(y_pred),3)
                 lcd.Print("Thank You",4)
                 break
                elif text=='nice':
                 print("Nice")
                 time.sleep(1) 
                 lcd.Print("You said : Nice ",2)
                 lcd.Print(str(y_pred),3)
                 lcd.Print("Thank You",4)
                 break
               
            except sr.UnknownValueError:
                time.sleep(1) 
                print("Didn't hear that try again")
                lcd.Print("Speak again  ",2)
                

speech_recog()
