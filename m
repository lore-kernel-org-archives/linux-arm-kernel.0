From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 15 Aug 2014 09:40:45 -0500
Subject: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <a46429bdbde94e23a458923f893b437e@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1408096156-29772-1-git-send-email-bhupesh.sharma@freescale.com>
 <1408096156-29772-5-git-send-email-bhupesh.sharma@freescale.com>
 <0E51617C-0C5C-4A9A-AB90-394FB7FBE55D@codeaurora.org>
 <a46429bdbde94e23a458923f893b437e@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <FBFA42DA-C94D-40B9-A4F8-714B26713790@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 15, 2014, at 9:26 AM, bhupesh.sharma at freescale.com wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak at codeaurora.org]
>> Sent: Friday, August 15, 2014 7:00 PM
>> To: Sharma Bhupesh-B45370
>> Cc: devicetree-discuss at lists.ozlabs.org; Catalin.Marinas at arm.com;
>> arnd at arndb.de; Will.Deacon at arm.com; Yoder Stuart-B08248;
>> grant.likely at secretlab.ca; Basu Arnab-B45036; linux-arm-
>> kernel at lists.infradead.org
>> Subject: Re: [PATCH 4/6] arm64: Add DTS support for FSL's LS2085A SoC
>> 
>> 
>> On Aug 15, 2014, at 4:49 AM, Bhupesh Sharma <bhupesh.sharma@freescale.com>
>> wrote:
>> 
>>> This patch adds the device tree support for FSL LS2085A SoC based on
>>> ARMv8 architecture.
>>> 
>>> Following levels of DTSI/DTS files have been created for the LS2085A
>>> SoC family:
>>> 
>>> - fsl-ls2085a.dtsi:
>>> DTS-Include file for FSL LS2085A SoC.
>>> 
>>> - fsl-ls2085a-simu.dts:
>>> DTS file for FSL LS2085a software simulator model.
>>> 
>>> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
>>> Signed-off-by: Arnab Basu <arnab.basu@freescale.com>
>>> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
>>> ---
>>> arch/arm64/boot/dts/fsl-ls2085a-simu.dts |   29 ++++++
>> 
>> Hmm, outside of something like qemu, we don't normally have simulation
>> model dts/support in the kernel.
> 
> Well for ARMv8 - foundation model is an existing simulation model having DTS
> support.
> 
> Regards,
> Bhupesh

True but that model was generally available to the open source community and was to get the base armv8 support going.

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
