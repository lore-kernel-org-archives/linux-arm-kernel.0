From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 6 Nov 2012 21:46:31 +0800
Subject: scheduler clock for MXS
In-Reply-To: <5098CB9F.9030401@meduna.org>
References: <50919AFF.3060602@meduna.org> <5093D8DE.70505@meduna.org>
 <20121105025753.GA26528@S2100-06.ap.freescale.net>
 <50978370.9060001@meduna.org>
 <20121105134655.GB27260@S2100-06.ap.freescale.net>
 <5097E4A9.3090008@meduna.org>
 <20121105222859.GI28327@n2100.arm.linux.org.uk>
 <5098CB9F.9030401@meduna.org>
Message-ID: <20121106134630.GD27643@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 09:34:39AM +0100, Stanislav Meduna wrote:
> Shawn: could you try change the
>   update_sched_clock();
> to
>   sched_clock_poll(sched_clock_timer.data);
> right after update_sched_clock call in setup_sched_clock?
> 
With the change, it still wraps at 2 seconds.

Shawn
