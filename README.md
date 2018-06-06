# Aws-Cleaner
Clean AWS Older than X AMI'S, Snapshots and unused Volumes
It's necessary to have ~/.aws/credentials on correct format, with all parameters:

[default]
aws_access_key_id = {KEY ID}
aws_secret_access_key = {SECRET ACCESS KEY}
region=us-east-1
output=text

[another_profile]
aws_access_key_id = {KEY ID}
aws_secret_access_key = {SECRET ACCESS KEY}
region=eu-west-1
output=text

Avaliable Regions

<table id="w191aab5c21c11b9">
<tbody>
<tr>
<th>Code</th>
<th>Name</th>
</tr>
<tr>
<td>
<p><code class="code">us-east-1</code></p>
</td>
<td>
<p>US East (N. Virginia)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">us-east-2</code></p>
</td>
<td>
<p>US East (Ohio)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">us-west-1</code></p>
</td>
<td>
<p>US West (N. California)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">us-west-2</code></p>
</td>
<td>
<p>US West (Oregon)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ca-central-1</code></p>
</td>
<td>
<p>Canada (Central)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">eu-central-1</code></p>
</td>
<td>
<p>EU (Frankfurt)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">eu-west-1</code></p>
</td>
<td>
<p>EU (Ireland)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">eu-west-2</code></p>
</td>
<td>
<p>EU (London)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">eu-west-3</code></p>
</td>
<td>
<p>EU (Paris)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-northeast-1</code></p>
</td>
<td>
<p>Asia Pacific (Tokyo)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-northeast-2</code></p>
</td>
<td>
<p>Asia Pacific (Seoul)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-northeast-3</code></p>
</td>
<td>
<p>Asia Pacific (Osaka-Local)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-southeast-1</code></p>
</td>
<td>
<p>Asia Pacific (Singapore)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-southeast-2</code></p>
</td>
<td>
<p>Asia Pacific (Sydney)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">ap-south-1</code></p>
</td>
<td>
<p>Asia Pacific (Mumbai)</p>
</td>
</tr>
<tr>
<td>
<p><code class="code">sa-east-1</code></p>
</td>
<td>
<p>South America (S&atilde;o Paulo)</p>
</td>
</tr>
</tbody>
</table>
