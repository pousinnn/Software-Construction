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
    let m=array.length;
    for(let i=0; i<m; i++){
        for(let k=0; k<m - 1; k++){
            if (array[k]>array[k+1]){
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
    let final = [];
    for(let i=array.length - 1; i>=0; i--){
        final.push(array[i]);
    }
    return final
}

function invertArrayInplace(array){
    let start=0;
    let end=array.length-1;
    while(start<end){
        let result=array[start];
        array[start]=array[end];
        array[end]=result;
        start++;
        end--;
    }
    return array;
}

//Problem 4: Receive a text and return a new one with  the first letter of each word capitalized
function capitalize(string){
    let final = "";
    let start=true;
    for(let i=0; i<string.length; i++){
        const letter=string[i];
        if(letter === " "){
            final += letter;
            start=true;
        }   
        else{
            if(start){
                final += letter.toUpperCase();
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
function mcd(a,b){
    if(b===0){
        return a;
    }
    return mcd(b,a%b);
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
        if(letter==="a"){
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
    for(let i=1; i<=number; i++){
        if(number%i ===0){
            list.push(i);
        }
    }
    return list;
}

//problem 8: eliminate duplicates in an array and gives back list without them
function deduplicate(array){
    let list=[];
    for(let i=0; i<array.length; i++){
        let single=array[i];
        let duplicated=false;
        for(let k=0; k<list.length; k++){
            if(list[k]=== single){
                duplicated=true;
            }
        }
        if(duplicated===false){
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
    let small=array[0].length;
    for(let i=1; i<array.length; i++){
        if(array[i].length<small){
            small=array[i].length;
        }
    }
    return small;
}

//problem 10: to check if a work is a palindromo
function isPalindrome(string){
    let final= "";
    let recorrido= string.length;
    for (let i= recorrido-1; i>=0; i--){
        final += string[i]
    }          
    if (final=== string){
        return true;
    }
    return false;
}

//probelma 11: take a list of texts and returns a new list with everything in alphabetical order
function sortStrings(array){
    let lista=[]
    for(let i=0; i<array.length; i++){
        lista.push(array[i]);
    }
    let m=lista.length;
    for(let i=0; i<m; i++){
        for(let k=0; k<m-1; k++){
            if(lista[k]>lista[k+1]){
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
        sum=sum+array[i];
        average=sum/array.length;
    }
    let mode = array[0];
    let list={};
    for(let k=0; k<array.length; k++){
        if(list[array[k]]===undefined){
            list[array[k]]=1;
        }
        else{
            list[array[k]]++;
        }
        if(list[array[k]]>list[mode]){
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
                list++;
            }
        }
        if(list>cantidad){
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
    for(let i=numb; i>1; i=i/2){
        if(i%2===0){
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
            if(list[k]<list[k+1]){
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

