From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 18:03:18 +0200
Subject: [PATCH v4 3/7] vfio: platform: introduce
 module_vfio_reset_handler macro
In-Reply-To: <1445615245-31124-4-git-send-email-eric.auger@linaro.org>
References: <1445615245-31124-1-git-send-email-eric.auger@linaro.org>
 <1445615245-31124-4-git-send-email-eric.auger@linaro.org>
Message-ID: <5491112.c5teuEVrvF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 17:47:21 Eric Auger wrote:
> The module_vfio_reset_handler macro
> - define a module alias
> - implement module init/exit function which respectively registers
>   and unregisters the reset function.
> 
> Signed-off-by: Eric Auger <eric.auger@linaro.org>
> 

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
