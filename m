From: dev@lynxeye.de (Lucas Stach)
Date: Sat, 28 Apr 2012 23:26:21 +0200
Subject: Tegra board file deprecation schedule
In-Reply-To: <4F9B0E7C.1060408@wwwdotorg.org>
References: <4F9B0E7C.1060408@wwwdotorg.org>
Message-ID: <1335648381.13148.4.camel@antimon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 27.04.2012, 15:24 -0600 schrieb Stephen Warren:
> Eventually, Tegra support will become device tree only in the mainline
> kernel; arch/arm/mach-tegra/board* will be deleted.
> 
> I propose the following policy towards this goal: I'd like to maintain
> the board files until the relevant device tree file has the same level
> of functionality. Once that is achieved, and a Linus kernel is release
> with full support for the board via device tree, the board files can be
> deleted from the next kernel release.
> 
> Does anyone have any issues with this?

Do we have any way to describe the clocks in the device tree? I'm
planning to add support for the Toradex Colibri T20 processor module,
which uses a 13MHz external OSC, so the generic clock init in the
current dt code definitely won't work for this board.

Thanks,
Lucas
