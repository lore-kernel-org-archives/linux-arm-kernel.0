From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 17 Mar 2012 21:16:30 +0000
Subject: [PATCH] drivers/base: fix compiler warning in SoC export driver -
 idr should be ida
In-Reply-To: <4F6456BD.9080205@linaro.org>
References: <4F6456BD.9080205@linaro.org>
Message-ID: <201203172116.30154.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 17 March 2012, Lee Jones wrote:
> 
> This fixes:
>   note: expected ?struct ida *? but argument is of type ?struct idr *?
>   warning: passing argument 1 of ?ida_pre_get? from incompatible pointer type
> 
> Reported-by: Arnd Bergman <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>
>  drivers/base/soc.c |    2 +-

Acked-by: Arnd Bergmann <arnd@arndb.de>

Greg, are you taking this through your tree?

	Arnd
