module.exports = class ViewHelpers
    # Returns a random integer between min (included) and max (included)
    @getRandomInteger: (min, max) ->
        Math.floor(Math.random() * (max - min + 1)) + min

    @getRandomElement: (array) ->
        array[exports.getRandomInteger(0, array.length - 1)]
    
    @getNumberString: (number) =>
        numberStrings = [
            'noll'
            'en'
            'två'
            'tre'
            'fyra'
            'fem'
            'sex'
            'sju'
            'åtta'
            'nio'
            'tio'
            'elva'
            'tolv'
        ]
        
        number = Math.abs(number)
        if number <= 12
            numberStrings[number]
        else if number >= 1000
            @formatThousands(number)
        else
            number.toString()

    # Extracts time from Date object, returns string in format HH.MM, e.g. '18.32'
    @getTimeString: (time) ->
        h = time.getHours()
        m = time.getMinutes()
        if m < 10 then m = '0' + m
        h + '.' + m
        
    # Converts percentage (float) to a nicely formatted string, e.g. 1.745 -> '1,7'
    # Note that this function also removes minus signs
    @formatPercentage: (percentage, decimals = 1) ->
        Math.abs(percentage).toFixed(decimals).replace('.', ',')
        
    # Converts/formats thousands (number), e.g 9816666 -> '9 816 666'
    # Note that this function also removes minus signs
    @formatThousands: (thousands) ->
        Math.abs(thousands).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ' ')
        
    @capitalizeFirstLetter: (string) ->
        string.charAt(0).toUpperCase() + string.slice(1)

    @getAdjective: (change) ->
        if change > 0
            'fler'
        else if change < 0
            'färre'
        else
            'oförändrat antal'

    @getVerb: (change) ->
        if change > 0
            'ökade'
        else if change < 0
            'minskade'
        else
            'var oförändrat'
            
    @getNoun: (change) ->
        if change > 0
            'ökning'
        else if change < 0
            'minskning'