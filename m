From: robh@kernel.org (Rob Herring)
Date: Thu, 19 May 2016 12:35:29 -0500
Subject: Regression: next-20160518: Clk? on BeagleBoard-X15
In-Reply-To: <20160519165719.GW5995@atomide.com>
References: <573DDFE6.8010209@ti.com> <20160519165719.GW5995@atomide.com>
Message-ID: <CAL_Jsq+ORQ5PP80_HbH16+SaHFLdrefcVGFzsvgLYiiwtq9PuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 11:57 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Nishanth Menon <nm@ti.com> [160519 08:48]:
>> I have'nt bisected yet, but the platform seems to have booted on
>> next-20160517
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160517/omap2plus_defconfig/am57xx-evm.txt
>>
>> https://github.com/nmenon/kernel-test-logs/blob/next-20160518/omap2plus_defconfig/am57xx-evm.txt
>
> Seems to be commit ac78f9bdcf38 ("drivers/of: Fix depth when
> unflattening devicetree").
>
> Rob, you need to start playing golf or something between -rc6 and
> the end of the merge window or something :)

It seems the fix for one board broke more... It is fixed in my tree now.

Rob
