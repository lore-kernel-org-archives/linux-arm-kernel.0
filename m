From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 06 Dec 2013 10:08:00 -0700
Subject: [PATCH 4/4] pinctrl: tegra: add pinmux controller driver for
 Tegra124
In-Reply-To: <52A16E65.70908@nvidia.com>
References: <1386241070-4350-1-git-send-email-ldewangan@nvidia.com>
 <1386241070-4350-5-git-send-email-ldewangan@nvidia.com>
 <52A10C7B.8070406@wwwdotorg.org> <52A16E65.70908@nvidia.com>
Message-ID: <52A20470.3040700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/2013 11:27 PM, Laxman Dewangan wrote:
> On Friday 06 December 2013 05:00 AM, Stephen Warren wrote:
>> On 12/05/2013 03:57 AM, Laxman Dewangan wrote:
>>> From: Ashwini Ghuge <aghuge@nvidia.com>
>>>
>>> This adds a driver for the Tegra124 pinmux, and required
>>> parameterization data for Tegra124.
>>>
>>> The driver uses the common Tegra pincontrol driver utility
>>> functions to implement the majority of the driver.
>>>
>>> This driver is not compatible with the earlier NVIDIA's SoCs,
>>> hence add new compatibile as "nvidia,tegra124-pinmux".
>>>
>>> Originally written by Ashwini Gguhe.
>>> ldewangan:
>>>          - cleanup the patches,
>>>          - Fix address issue.
...
>> (BTW, those 2 patches would go through the pinctrl tree, and patches 2/4
>> and 3/4 would go through the Tegra tree. You generally shouldn't posted
>> patches that will be applied to different trees in the same series,
>> since there aren't dependencies).
>
> Fine.
> Should I sent the diff or full change? I think full change as this need
> to go on pincontrol subsystem, not in Tegra.

Please send complete patches for the new driver. The patch I have in my
local tree isn't going anywhere; I just have the early version that
Ashwini posted applied locally for testing. A final complete patch
should be sent to the pinctrl maintainer in the normal way.
