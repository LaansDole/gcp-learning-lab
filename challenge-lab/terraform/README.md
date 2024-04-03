## Terraform Fundamentals

- ***Activate Cloud Shell and Editor***

The resource block has two strings before opening the block: the resource type and the resource name. For this lab, the resource type is `google_compute_instance` and the name is `terraform`. The prefix of the type maps to the provider: `google_compute_instance` automatically tells Terraform that it is managed by the Google provider.

### Initialization
*Run the comman in the same directory as the `.tf` file*
* To initialize a new Terraform configuration
```shell
terraform init
```

### Managing resources
To apply the configuration:
```shell
terraform apply
```
- The prefix `~` means that Terraform will update the resource in-place
- The prefix `-/+` means that Terraform will destroy and recreate the resource, rather than updating it in-place. While some attributes can be updated in-place (which are shown with the `~` prefix), changing the boot disk image for an instance requires recreating it. Terraform and the Google Cloud provider handle these details for you, and the execution plan makes it clear what Terraform will do.

```shell
terraform show
```
To see the state of the resources
```shell
terraform destroy
```
To remove all resources from the configuration

### Planning the resources (for the future)
- You can see what will be created before applying it with `terraform plan`
- Or you can save the plan so that you can apply exactly the same plan in the future
```shell
terraform plan -out <file_name>
```
- To apply this plan
```shell 
terraform apply <file_name>
```