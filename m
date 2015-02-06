From: mpeg.blue@free.fr (Mason)
Date: Fri, 06 Feb 2015 13:17:56 -0800
Subject: Delays, clocks, timers, hrtimers, etc
In-Reply-To: <e028a4eb604a491f4438557f4a1373ef@agner.ch>
References: <54C8E125.3070905@free.fr>
 <e028a4eb604a491f4438557f4a1373ef@agner.ch>
Message-ID: <54D52F84.9050600@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Agner wrote:

> Just recently I added support of ARM global timer as clocksource for
> Vybrid SoC. This SoC doesn't use cpufreq, hence it is safe to use the
> ARM global timer. The nice thing of device tree is, the patch to add
> support for that did not change a single line of code:
>
> http://thread.gmane.org/gmane.linux.kernel/1794460

Hello Stefan,

Your changes are not yet accepted in mainline, are they?
(I don't see them in 3.18.5)

Do you also use the ARM local timers in your port?
Is there generic code to handle them?

Regards.
