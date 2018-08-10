From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 10 Aug 2018 09:10:26 +0100
Subject: [PATCH v2 04/29] nvmem: provide nvmem_dev_name()
In-Reply-To: <20180810080526.27207-5-brgl@bgdev.pl>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180810080526.27207-5-brgl@bgdev.pl>
Message-ID: <45fda8c0-aa09-3c4b-69ee-9a61265f1120@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/08/18 09:05, Bartosz Golaszewski wrote:
>   
> +const char *nvmem_dev_name(struct nvmem_device *nvmem)
> +{
> +	return dev_name(&nvmem->dev);
> +}
> +EXPORT_SYMBOL_GPL(nvmem_dev_name);
> +
Kernel doc for this is missing!
Other than that it looks good to me!

--srini
