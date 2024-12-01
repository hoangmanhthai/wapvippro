{% use '_blocks' %}
{% set title = 'Login to Dashboard' %}
{% from '_func' import is_login %}
{% if is_login()|trim == 'true' %}{{redirect('/manager')}}{% endif %}
{{block('header')}}

<article class="text-center">
    <header>
        <h1>Login</h1>
    </header>
{% if request_method()|lower == 'post' %}
    {% set user = get_data_by_id('users', 1).data %}
    {% set input_nick, input_pass = get_post('nick')|lower, get_post('pass')|lower %}
    {% if user['nick'] == input_nick and user['pass'] == md5(input_pass) %}
        {% do set_cookie('token', user['pass']) %}
        {{redirect('/manager')}}
    {% else %}
        <p class="alert alert-warning">Please check your login information again</p>
    {% endif %}
{% endif %}
    <form method="post">
        <!-- Email input -->
        <div data-mdb-input-init class="form-outline mb-4">
            <input placeholder="Username" 
            type="text" class="form-control" name="nick" required pattern="[A-Za-z0-9]+"/>
        </div>

        <!-- Password input -->
        <div data-mdb-input-init class="form-outline mb-4">
            <input placeholder="Password"
            type="password" name="pass" required="" class="form-control" />
        </div>

        <!-- Submit button -->
        <button type="submit" class="btn btn-primary btn-block form-control">Submit</button>
    </form>
</article>

{{block('footer')}}