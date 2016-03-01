From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Mar 2016 22:49:20 +0100
Subject: [PATCH] rtc: mt6397: Remove plaform module alias
In-Reply-To: <1456334780-17380-1-git-send-email-javier@osg.samsung.com>
References: <1456334780-17380-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20160301214920.GI23985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/02/2016 at 14:26:20 -0300, Javier Martinez Canillas wrote :
> The driver uses the MODULE_ALIAS() macro to export a platform module alias
> to allow the module to be autoloaded if the device is registered using the
> legacy platform registration mechanism but the driver is always used by OF
> only machines so the alias is not needed and should just be removed.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> Hello,
> 
> This patch supersedes "rtc: mt6397: Add platform device ID table":
> https://lkml.org/lkml/2016/2/9/192.
> 
> Best regards,
> Javier
> 
>  drivers/rtc/rtc-mt6397.c | 1 -
>  1 file changed, 1 deletion(-)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
