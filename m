From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Jul 2014 05:04:56 -0700
Subject: [PATCH 0/5] Add gta04 board variants
In-Reply-To: <1405369228-27197-1-git-send-email-marek@goldelico.com>
References: <1405369228-27197-1-git-send-email-marek@goldelico.com>
Message-ID: <20140715120455.GC28715@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Marek Belisko <marek@goldelico.com> [140714 13:22]:
> This patch series completes the GTA04 device tree to describe all hardware
> components that are on the different variants of the GTA04 boards.
> 
> Marek Belisko (5):
>   arm: dts: omap3-gta04: Add missing nodes to fully describe gta04 board
>   arm: dts: omap3-gta04: Rename gta04.dts to gta04.dtsi and add a4 model
>   arm: dts: Add gta04a3 model
>   arm: dts: Add gta04+b2 model bindings
>   arm: dts: Add gta04+b3 model bindings

Hmm at least the first patch won't apply:

Hunk #4 FAILED at 143.
Hunk #5 succeeded at 142 with fuzz 2 (offset -26 lines).
Hunk #6 succeeded at 287 (offset -26 lines).
Hunk #7 succeeded at 364 (offset -26 lines).
Hunk #8 succeeded at 433 (offset -26 lines).
Hunk #9 succeeded at 472 (offset -26 lines).
Hunk #10 succeeded at 485 (offset -26 lines).
Hunk #11 succeeded at 556 (offset -26 lines).
Hunk #12 FAILED at 720.
2 out of 12 hunks FAILED -- rejects in file arch/arm/boot/dts/omap3-gta04.dts

Can you please repost against let's say v3.16-rc1? Maybe also
check they apply cleanly against omap-for-v3.17/dt branch that
I just pushed out to:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap omap-for-v3.17/dt

Thanks,

Tony
