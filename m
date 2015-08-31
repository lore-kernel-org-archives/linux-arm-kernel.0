From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 31 Aug 2015 22:09:44 +0200
Subject: [PATCH] rtc: Fix module autoload for rtc-{ab8500,max8997,s5m}
 drivers
In-Reply-To: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
References: <1440671672-26590-1-git-send-email-javier@osg.samsung.com>
Message-ID: <20150831200944.GA3409@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/08/2015 at 12:34:32 +0200, Javier Martinez Canillas wrote :
> These platform drivers have a platform device ID table but the module
> alias information is not created so module autoloading will not work.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> 
> ---
> 
>  drivers/rtc/rtc-ab8500.c  | 1 +
>  drivers/rtc/rtc-max8997.c | 1 +
>  drivers/rtc/rtc-s5m.c     | 1 +
>  3 files changed, 3 insertions(+)
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
