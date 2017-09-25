From: icenowy@aosc.io (Icenowy Zheng)
Date: Mon, 25 Sep 2017 18:12:09 +0800
Subject: [PATCH 0/3] Simple DVFS support for Allwinner A64 SoC
In-Reply-To: <20170925101027.lghnnll4h6inreqm@flea.home>
References: <20170923001531.14285-1-icenowy@aosc.io>
 <20170925101027.lghnnll4h6inreqm@flea.home>
Message-ID: <27EF78BD-6285-4D8D-AA65-8294D797E2FB@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



? 2017?9?25? GMT+08:00 ??6:10:27, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
>Hi,
>
>On Sat, Sep 23, 2017 at 12:15:28AM +0000, Icenowy Zheng wrote:
>> This patchset imports simple DVFS support for Allwinner A64 SoC.
>> 
>> As the thermal sensor driver is not yet implemented and some boards
>> have still no AXP PMIC support, now only two OPPs are present --
>> 648MHz at 1.04V and 816MHz at 1.1V to prevent overheat or undervoltage.
>> 
>> PATCH 1 is a fix to the CCU driver of A64, and the remaining patches
>> set up the device tree bits of the DVFS on Pine64.
>
>How has this been tested?
>
>What tasks did you run, with what governor, etc...

I only tested manual frequency switching between 648MHz and
816MHz, and tested the PLL stuck issue by change the OPPs to
some random value.

>
>Thanks!
>Maxime
