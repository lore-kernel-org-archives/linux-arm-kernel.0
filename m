From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 9 Jul 2013 18:14:34 +0200
Subject: [PATCH V3 2/3] clocksource: mmp: support CLOCKSOURCE OF DECLARE
In-Reply-To: <1373352166-10064-3-git-send-email-zhangwm@marvell.com>
References: <1373352166-10064-1-git-send-email-zhangwm@marvell.com>
 <1373352166-10064-3-git-send-email-zhangwm@marvell.com>
Message-ID: <20130709181434.76f6216d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Neil Zhang,

On Tue, 9 Jul 2013 14:42:45 +0800, Neil Zhang wrote:
> support CLOCKSOURCE OF DECLARE for mmp timer.
> 
> Signed-off-by: Neil Zhang <zhangwm@marvell.com>
> ---
>  arch/arm/mach-mmp/mmp-dt.c  |    5 ++---
>  arch/arm/mach-mmp/mmp2-dt.c |    3 +--
>  arch/arm/mach-mmp/time.c    |   15 ++-------------
>  3 files changed, 5 insertions(+), 18 deletions(-)

Maybe it would be good to take this opportunity to move
arch/arm/mach-mmp/time.c into drivers/clocksource/.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
