From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 08:32:09 +0100
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <20180907100750.14564-2-brgl@bgdev.pl>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
Message-ID: <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/09/18 11:07, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Remove all APIs dealing with nvmem_cell_info. There are no users and
> this part of the subsystem will be reworked.
> 
> This patch temprarily disables support for non-DT users.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>   drivers/nvmem/core.c           | 212 ++-------------------------------
>   include/linux/nvmem-consumer.h |  26 ----
>   include/linux/nvmem-provider.h |  13 --
>   3 files changed, 12 insertions(+), 239 deletions(-)

This looks totally un-necessary, Other patches in this series adds them 
back.. Consider updating these in those respective patches.!



-srini
