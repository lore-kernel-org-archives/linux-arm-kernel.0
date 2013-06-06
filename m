From: r.sricharan@ti.com (Sricharan R)
Date: Thu, 6 Jun 2013 23:21:17 +0530
Subject: [PATCH 2/4] ARM: dts: omap5-uevm: Add USB Host support
In-Reply-To: <20130605135739.GA11193@kahuna>
References: <1370414770-1485-1-git-send-email-r.sricharan@ti.com>
 <1370414770-1485-3-git-send-email-r.sricharan@ti.com>
 <20130605135739.GA11193@kahuna>
Message-ID: <51B0CC15.6010809@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Wednesday 05 June 2013 07:27 PM, Nishanth Menon wrote:
> On 12:16-20130605, Sricharan R wrote:
>> From: Roger Quadros <rogerq@ti.com>
> [...]
>> diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
>> index 843a001..cf862df 100644
>> --- a/arch/arm/boot/dts/omap5-uevm.dts
>> +++ b/arch/arm/boot/dts/omap5-uevm.dts
> <snip>
>> +	/* hsusb2_phy is clocked by FREF_CLK1 i.e. auxclk1 */
>> +	clock_alias {
>> +		clock-name = "auxclk1_ck";
>> +		clock-alias = "main_clk";
> is'nt this better to use with clock node?
Roger was suggesting to remove this for now. Posted
V2 following that.
Are you suggesting to go with your clock-binding patch ?

Regards,
 Sricharan
