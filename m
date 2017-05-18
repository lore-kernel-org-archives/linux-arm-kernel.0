From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 18 May 2017 19:16:55 +0800
Subject: next-20170518 build: 1 failures 4 warnings (next-20170518)
In-Reply-To: <20170518103607.u7l7vr2rnv3rsysu@sirena.org.uk>
References: <E1dBFeZ-0004Qr-Jp@optimist>
 <20170518103607.u7l7vr2rnv3rsysu@sirena.org.uk>
Message-ID: <C252950D-15D8-48DB-9149-799546627FC2@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?5?18? GMT+08:00 ??6:36:07, Mark Brown <broonie@kernel.org> ??:
>On Thu, May 18, 2017 at 08:15:19AM +0100, Build bot for Mark Brown
>wrote:
>
>Today's -next fails to build an ARM allmodconfig due to:
>
>> 	arm-allmodconfig
>> Error: ../arch/arm/boot/dts/sun8i-v3s-licheepi-zero-dock.dts:69.17-18
>syntax error
>
>caused by ff175ef29e9069ac46 (ARM: sun8i: v3s: add support for Lichee
>Pi
>Zero w/ dock board).  

I sent a fix and Maxime said that he has squashed it into the
original patch.

P.S. I also forgot to write the dtb file into Makefile, so it passed
my local build. Does the CI build have different build system
for DTBs?
