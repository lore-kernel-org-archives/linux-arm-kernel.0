From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 31 Aug 2015 22:15:23 +0200
Subject: [PATCH] rtc: Fix module autoload for OF platform drivers
In-Reply-To: <1440676322-19870-1-git-send-email-javier@osg.samsung.com>
References: <1440676322-19870-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20150831201523.GB3409@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2015 at 13:52:02 +0200, Javier Martinez Canillas wrote :
> These platform drivers have a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-armada38x.c | 1 +
>  drivers/rtc/rtc-coh901331.c | 1 +
>  drivers/rtc/rtc-da9063.c    | 1 +
>  drivers/rtc/rtc-moxart.c    | 1 +
>  drivers/rtc/rtc-mpc5121.c   | 1 +
>  drivers/rtc/rtc-mt6397.c    | 1 +
>  drivers/rtc/rtc-mv.c        | 1 +
>  drivers/rtc/rtc-vt8500.c    | 1 +
>  8 files changed, 8 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
