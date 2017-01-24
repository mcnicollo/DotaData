$.support.cors = true;  //global

ko.bindingHandlers.date =
{
    update: function (element, valueAccessor, allBindingsAccessor, viewModel)
    {
        var val = valueAccessor();

        var formatted = ""; 
        var date = moment(ko.utils.unwrapObservable(val)); 
        var format = allBindingsAccessor().format || 'MMM D, YYYY h:mm A'; //default format

        if (date && date.isValid())
        {
            formatted = date.format(format);
        }

        element.innerText = formatted;
    }
};

ko.bindingHandlers.bootstrapModal = {
    init: function (element, valueAccessor)
    {
        $(element).modal({
            show: false
        });

        var value = valueAccessor();
        if (ko.isObservable(value))
        {
            $(element).on('hide.bs.modal', function ()
            {
                value(false);
            });
        }
        ko.utils.domNodeDisposal.addDisposeCallback(element, function ()
        {
            $(element).modal("destroy");
        });

    },
    update: function (element, valueAccessor)
    {
        var value = valueAccessor();
        if (ko.utils.unwrapObservable(value))
        {
            $(element).modal('show');
        } else
        {
            $(element).modal('hide');
        }
    }
}


getValidationErrors = function (error)
{
    if (!error.responseJSON)
    {
        return null;
    }

    if (!error.responseJSON.ResponseStatus)
    {
        return null;
    }

    if (error.responseJSON.ResponseStatus.Errors.length == 0)
    {
        return null;
    }

    return error.responseJSON.ResponseStatus.Errors
}


