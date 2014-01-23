From: galak@codeaurora.org (Kumar Gala)
Date: Thu, 23 Jan 2014 13:59:28 -0600
Subject: [PATCH 0/2] Enable clock controllers on MSM
In-Reply-To: <878uu6y5im.fsf@paris.lan>
References: <1389921904-3777-1-git-send-email-sboyd@codeaurora.org>
 <878uu6y5im.fsf@paris.lan>
Message-ID: <DBC6E587-D188-4DA7-B898-D1DF34613320@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Jan 23, 2014, at 11:25 AM, Kevin Hilman <khilman@linaro.org> wrote:

> Stephen Boyd <sboyd@codeaurora.org> writes:
> 
>> These patches add the clock controller nodes, enable the clock drivers
>> on MSM based platforms, and hook it up enough to get the serial console
>> working. This is based on the merge of Mike's clk-next branch with
>> linux-next-20140116. The changes need the clk-next branch because that's
>> where the DTS include files landed.
> 
> I forgot to repond to this earlier, but I tested this on top of -next
> and it gets the dragonboard booting w/mainline.  Yay!
> 
>> Perhaps this can be applied after 3.14-rc1 is out?
> 
> Yeah, sounds good.
> 
> Kevin

We?ll need arm-soc to pull in the clk changes from Mike?s tree for that.

> Stephen Boyd (2):
>>  ARM: dts: msm: Add clock controller nodes and hook into uart
>>  ARM: msm_defconfig: Enable MSM clock drivers
>> 
>> arch/arm/boot/dts/qcom-msm8660-surf.dts | 11 +++++++++++
>> arch/arm/boot/dts/qcom-msm8960-cdp.dts  | 18 ++++++++++++++++++
>> arch/arm/boot/dts/qcom-msm8974.dtsi     | 24 ++++++++++++++++++++++++
>> arch/arm/configs/msm_defconfig          |  4 ++++
>> 4 files changed, 57 insertions(+)

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
