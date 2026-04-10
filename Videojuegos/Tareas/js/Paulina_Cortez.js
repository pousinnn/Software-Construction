//Actividad en clase: Javascript
//Pau Cortez Balvanera | A01782041
//April 08, 2026

"use strict";

//Problem 1: primer caracter de una cadena de texto
function firstNonRepeating(string){ //we create a function with a parameter that considers strings
    if(string.length===0){ //in case we have empty strings
        return undefined;
    }
    for(let i=0; i<string.length; i++){ //in here we consider the string point by point starting from zero
        let contador=0
    for(let k=0; k<string.length;k++){ //cycle to consider every string once again
        if(string[i]===string[k]){ //considers if the letters are the same
            contador=contador+1 //increase counter
        }
    }
    if(contador===1){ //check if counter(the letter) appears once
        return string[i]; //function finishes if it is not repeated
    }
    }
    return undefined; // incase no letter makes sense
}

//Problem 2: bubbleSort
function bubbleSort(array){
    let m=array.length; //set array size
    for(let i=0; i<m; i++){ //cycle to repeat the process various times
        for(let k=0; k<m - 1; k++){
            if (array[k]>array[k+1]){  //will compare elements and swap them according to their size (do the bubble process)
                let exchange=array[k];
                array[k]=array[k+1];
                array[k+1]=exchange;
            }
        }
    }
    return array;
}

//Problem 3: Invert a set of numbers and be able to modify it
function invertArray(array){
    let final = []; //we set an empty array
    for(let i=array.length - 1; i>=0; i--){ //cycle that allows to start from the end of the array and c"count backwards"
        final.push(array[i]); //pushes the elements in reverse
    }
    return final
}

function invertArrayInplace(array){
    let start=0;
    let end=array.length-1; //consider the start and end of the array
    while(start<end){ //loops the process of swapping either fisrt or last
        let result=array[start];
        array[start]=array[end];
        array[end]=result;
        start++; //we move them
        end--;
    }
    return array;
}

//Problem 4: Receive a text and return a new one with  the first letter of each word capitalized
function capitalize(string){
    let final = "";
    let start=true; //considers that we are dealing with uppercases and a new word will be checked
    for(let i=0; i<string.length; i++){
        const letter=string[i];
        if(letter === " "){ //will take into account spaces in order to consider words
            final += letter;
            start=true;
        }   
        else{
            if(start){
                final += letter.toUpperCase(); //uses a function to capitalize the first letter
                start = false;
            }
            else{
                final += letter;
            }
        }
    }
    return final;
}

//problem 5: mcd will calculate maximum divisor
function mcd(a, b){
    if(a=== 0){ //will consider the cases where we are given 0
        return 0;
    }
    if(b=== 0){
        return 0;
    }
    let small; //in here we pin the number that is smaller (either a or b)
    if(a<b){
        small= a;
    } else {
        small= b;
    }
    for(let i=small; i>=1; i--){ //we start with the bigger number and go decreasing

        if(a% i=== 0){ //we use the residue to check if it can be divisible - if is can be divided by both then we take it
            if(b%i === 0){
                return i;
            }
        }
    }

    return 1; //in case there is nothing we will only consider number 1
}

//probelm 6: hackerspeak will change a text to 'hackerspeak'
//note: hackerspeak will alternate a spelling considering latin 
// letters, numbers and special characters that resamble the original letters
//note 2: the "alphabet' i am considering for this excercise comes from the test, not the actual letters

function hackerSpeak(string){
    if(string=== ""){
        return "";
    }
    let exchange= "";
    for(let i=0; i<string.length; i++){
        let letter=string[i];
        if(letter==="a"){ //literally is set to exchange the letter
            exchange +=4;
        }
        else if(letter=== "e"){
            exchange +="3";
        }
        else if(letter=== "i"){
            exchange +="1";
        }
        else if(letter=== "o"){
            exchange +="0";
        }
        else if(letter=== "s"){
            exchange +="5";
        }
        else{
            exchange += letter;
        }
    }
    return exchange;
}

//problem 7: factorize will be able to receive a number and give back a list with all the elements left
function factorize(number){
    if(number===0){
        return[];
    }
    let list=[];
    for(let i=1; i<=number; i++){ //cycle that tries all numbers starting from 1
        if(number%i ===0){ //in case it can divide without residue it will be a factor
            list.push(i); //pushes
        }
    }
    return list;
}

//problem 8: eliminate duplicates in an array and gives back list without them
function deduplicate(array){ 
    let list=[];
    for(let i=0; i<array.length; i++){
        let single=array[i];
        let duplicated=false; //tries to avoid element that is not repeated yet if found will be marked
        for(let k=0; k<list.length; k++){
            if(list[k]=== single){ 
                duplicated=true;
            }
        }
        if(duplicated===false){ //will remove the repeated ones and only add the ones who are single
            list.push(single);
        }
    }
    return list;
}

//problem 9: will receive a list with different texts and will give the lenght of the shorthes one
function findShortestString(array){
    if(array.length===0){
        return 0;
    }
    let small=array[0].length; //will start with the fisrt lenght and will "eliminate" according if a smaller one is found
    for(let i=1; i<array.length; i++){
        if(array[i].length<small){ //will update the list in case it is smaller
            small=array[i].length;
        }
    }
    return small;
}

//problem 10: to check if a work is a palindromo
function isPalindrome(string){
    let final= "";
    let recorrido= string.length;
    for (let i= recorrido-1; i>=0; i--){ //cycle that reverses the string
        final += string[i] //will build the reversed string
    }          
    if (final=== string){ //will compare to the original and check if it reads the same
        return true;
    }
    return false;
}

//probelma 11: take a list of texts and returns a new list with everything in alphabetical order
function sortStrings(array){ //will be comparing values in terms of alphabetical comparison and will exchange places according to the order
    let lista=[]
    for(let i=0; i<array.length; i++){
        lista.push(array[i]);
    }
    let m=lista.length;
    for(let i=0; i<m; i++){
        for(let k=0; k<m-1; k++){
            if(lista[k]>lista[k+1]){ //works with the string in terms of alphabet
                let final=lista[k];
                lista[k]=lista[k+1];
                lista[k+1]=final
            }
        }
    }
    return lista;
}

//problema 12: stats will take a list of numbers and will return a list with two elements; mean and mode
function stats(array){
    if(array.length===0){
        return[0,0];
    }
    let sum=0;
    let average=0;
    for(let i=0; i<array.length; i++){
        sum=sum+array[i]; //to obtain the value of average
        average=sum/array.length;
    }
    let mode = array[0];
    let list={}; //in order to count how many times a number appears
    for(let k=0; k<array.length; k++){
        if(list[array[k]]===undefined){
            list[array[k]]=1;
        }
        else{
            list[array[k]]++; //counts the times it appears
        }
        if(list[array[k]]>list[mode]){ //will change according to what is most repeated
            mode=array[k];
        }
    }
    return[average,mode];
}

//problema 13: list of text and retruns the most frequent one
function popularString(array){
    if(array.length===0){
        return "";
    }
    let most=array[0];
    let cantidad=0;
    for(let i=0; i<array.length; i++){
        let list=0;
        for(let k=0; k<array.length; k++){
            if(array[i]===array[k]){
                list++; //will count the repetition of a string
            }
        }
        if(list>cantidad){ //cycle that checks we are keeping the most frequent
            cantidad=list;
            most=array[i];
        }
    }
    return most;
}

//problem 14: take a number from list and retrun true if ist a power or fake if not
function isPowerOf2(numb){
    if(numb<=0){
        return false;
    }
    for(let i=numb; i>1; i=i/2){ //cycle to check if we can divide the number by two 
        if(i%2===0){ //discard the numbers that are not divisible by 2
        }
        else{
            return false;
        }
    }
    return true;
}

//problem 15: list that will return a new list with all the numbers in descending order
function sortDescending(array){
    let list=[];
    for(let i=0; i<array.length; i++){
        list.push(array[i]);
    }
    let m=list.length;
    for(let i=0; i<m; i++){
        for(let k=0; k<m-1;k++){
            if(list[k]<list[k+1]){ //will compare according to the order in reverse creating the descending order
                let final=list[k];
                list[k]=list[k+1];
                list[k+1]=final;
            }
        }
    }
    return list;
}


export {
    firstNonRepeating,
    bubbleSort,
    invertArray,
    invertArrayInplace,
    capitalize,
    mcd,
    hackerSpeak,
    factorize,
    deduplicate,
    findShortestString,
    isPalindrome,
    sortStrings,
    stats,
    popularString,
    isPowerOf2,
    sortDescending,
};

