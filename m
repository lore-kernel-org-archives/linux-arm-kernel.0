From: alexey.brodkin@synopsys.com (Alexey Brodkin)
Date: Fri, 16 Nov 2018 11:41:18 +0000
Subject: [PATCH 3/9] drm: replace "drm_dev_unref" function with
 "drm_dev_put"
In-Reply-To: <20181115221634.22715-4-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-4-greenfoo@gluegarage.com>
Message-ID: <32f96995d5abf3844975a156dee38d21ea666c52.camel@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fernando,

On Thu, 2018-11-15 at 23:16 +0100, Fernando Ramos wrote:
> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
> 
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>
> ---
>  drivers/gpu/drm/arc/arcpgu_drv.c             | 4 ++--

For ARCPGU

Acked-by: Alexey Brodkin <abrodkin@synopsys.com>
