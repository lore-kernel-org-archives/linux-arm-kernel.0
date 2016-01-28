From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Thu, 28 Jan 2016 13:54:26 -0500
Subject: [PATCH v6 6/7] ARM: dts: imx: Add support for Advantech/GE B650v3
In-Reply-To: <20160128061919.GG9070@tiger>
References: <1450908016-17384-1-git-send-email-akshay.bhat@timesys.com>
 <1450908016-17384-7-git-send-email-akshay.bhat@timesys.com>
 <20160128061919.GG9070@tiger>
Message-ID: <56AA63E2.5090103@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/28/2016 01:19 AM, Shawn Guo wrote:
> On Wed, Dec 23, 2015 at 05:00:15PM -0500, Akshay Bhat wrote:
>> Add support for Advantech/GE B650v3 board.
>>
>> Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
>> ---
>>   arch/arm/boot/dts/Makefile         |   1 +
>>   arch/arm/boot/dts/imx6q-b650v3.dts | 114 +++++++++++++++++++++++++++++++++++++
>
> I compare it with imx6q-b450v3.dts.  They are basically identical except
> model name and compatible string.  What are the differences between
> these two boards from hardware POV?  Can we support them with one
> dts/dtb, so that we can save one duplicated dts?
>
> Shawn

The boards are different form factors. Since the hardware layout is 
different there are some board specific imx6 register settings needed 
(eg: usb phy settings, pcie gpr8 settings etc.).  We are in the process 
of submitting imx driver patches for the same and expect the 
imx6q-b450v3.dts and imx6q-b650v3.dts to be different in the near 
future. Hence would like to keep them separate.

https://patchwork.ozlabs.org/patch/568166/

Thanks,
Akshay
