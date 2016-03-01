From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 1 Mar 2016 18:37:43 +0100
Subject: [PATCH] rtc: vr41xx: remove unused function:
In-Reply-To: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
References: <1456851797-3510153-1-git-send-email-arnd@arndb.de>
Message-ID: <20160301173743.GC23985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 01/03/2016 at 18:03:12 +0100, Arnd Bergmann wrote :
> The vr41xx_rtc_alarm_irq_enable function is never called
> has no effect other than producing a warning:
> 
> drivers/rtc/rtc-vr41xx.c:228:12: error: 'vr41xx_rtc_alarm_irq_enable' defined but not used [-Werror=unused-function]
> 
> This removes it.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For that one, I took Geert's patch which makes use of the function and
is a proper fix.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
