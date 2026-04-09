//Actividad en clase: Javascript
//Pau Cortez Balvanera | A01782041
//April 08, 2026

//Problem 1: primer caracter de una cadena de texto
function firstNonRepeating(str){ //we create a function with a parameter that considers strings
    if(str.length===0){ //in case we have empty strings
        return undefined;
    }
    for(let i=0; i<str.length; i++){ //in here we consider the string point by point starting from zero
        let contador=0
    for(let k=0; k<str.length;k++){ //cycle to consider every string once again
        if(str[i]===str[k]){ //considers if the letters are the same
            contador=contador+1 //increase counter
        }
    }
    if(contador===1){ //check if counter(the letter) appears once
        return str[i]; //function finishes if it is not repeated
    }
    }
    return undefined; // incase no letter makes sense
}

//Problem 2: bubbleSort
function bubbleSort(arr){
    let n=arr.length;
    for(let i=0; i<m; i++){
        for(let k=0; k<m - 1; k++){
            if (arr[k]>arr[k+1]){
                let exchange=arr[k];
                arr[k]=arr[k+1];
                arr[k+1]=exchange;
            }
        }
    }
    return arr;
}

//Problem 3: Invert a set of numbers and be able to modify it
function invertArray(arr){
    let final = [];
    for(let i=arr.length - 1; i>=0; i--){
        final.push(arr[i]);
    }
    return final
}
function invertArrayInplace(arr){
    let start=0;
    let end=arr.length-1;
    while(start<end){
        let result=arr[start];
        arr[start]=arr[end];
        arr[end]=result;
        start++;
        end--;
    }
    return arr;
}

//Problem 4: Receive a text and return a new one with  the first letter of each word capitalized
function capitalize(str){
    if(str===""){
        return "";
    }
    let palabras="";
    for(let i=0; i<str.length, i++){
        if(i===0||str[i-1])
    }
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

