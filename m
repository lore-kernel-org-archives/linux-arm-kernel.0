From: robh@kernel.org (Rob Herring)
Date: Sat, 17 Nov 2018 09:45:31 -0600
Subject: [PATCH v2 12/25] of: net: kill of_get_nvmem_mac_address()
In-Reply-To: <20181113140133.17385-13-brgl@bgdev.pl>
References: <20181113140133.17385-1-brgl@bgdev.pl>
 <20181113140133.17385-13-brgl@bgdev.pl>
Message-ID: <20181117154531.GA7306@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Nov 2018 15:01:20 +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> We've switched all users to nvmem_get_mac_address(). Remove the now
> dead code.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/of/of_net.c    | 39 ---------------------------------------
>  include/linux/of_net.h |  6 ------
>  2 files changed, 45 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
