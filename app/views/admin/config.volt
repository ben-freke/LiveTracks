{% include 'panelBase.volt' %}
{% include 'adminNavbar.volt' %}


<div class="row">
    <div class="col-md-6 col-md-offset-3" style="font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', sans-serif;" >
        <h3 class="text-center" style="font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', sans-serif; text-transform: uppercase;"><b>Configuration</b></h3>
        <br>
        <form method="post" action="/admin/config">
            <table class=table style="font-family: 'Montserrat', 'Helvetica Neue', 'Helvetica', sans-serif;">
                <thead>
                <tr>
                    <th>Variable</th>
                    <th>Value</th>
                </tr>
                </thead>
                <tbody>
            {% for variable in configurables %}
                <tr>
                    <td> <input type="text" name="firstName" class="form-control" placeholder="{{ variable.variable }} "></td>
                    <td> <input type="text" name="firstName" class="form-control" placeholder="{{ variable.value }} "></td>
                </tr>
            {% endfor %}
                </tbody>
            </table>
            <div class="text-center"><button type="submit" class="btn btn-success">Save</button></div>

        </form>
    </div>
</div>


