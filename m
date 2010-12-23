From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 23 Dec 2010 15:05:03 +0100
Subject: [PATCH v5 4/5] OMAP4: hwmod: Add inital data for smartreflex
	modules.
In-Reply-To: <AANLkTi=P-3aQSk3Q2WyAAp-8WwwtxC_aOGLW+7WGd4mj@mail.gmail.com>
References: <1292864437-15353-1-git-send-email-thara@ti.com>
	<1292864437-15353-5-git-send-email-thara@ti.com>
	<4D133B78.5030807@ti.com>
	<AANLkTi=P-3aQSk3Q2WyAAp-8WwwtxC_aOGLW+7WGd4mj@mail.gmail.com>
Message-ID: <4D13570F.9050503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/23/2010 2:25 PM, Menon, Nishanth wrote:
> On Thu, Dec 23, 2010 at 06:07, Cousson, Benoit<b-cousson@ti.com>  wrote:
>
>>
>> Please note the following log when enabling SR in Class 3 on an OMAP4430/sdp:
>>
>> [    2.362182] omap2_set_init_voltage: unable to find boot up OPP for vdd_mpu
>> [    2.369384] omap2_set_init_voltage: Unable to put vdd_mpu to its init voltage
>> [    2.369384]
>> [    2.378875] omap2_set_init_voltage: unable to find boot up OPP for vdd_iva
>> [    2.386108] omap2_set_init_voltage: Unable to put vdd_iva to its init voltage
>> [    2.386108]
>> [    2.396484] Power Management for TI OMAP4.
>> [    2.401031] sr_init: No PMIC hook to init smartreflex
>> [    2.406494] smartreflex smartreflex.0: omap_sr_probe: SmartReflex driver initialized
>> [    2.414825] smartreflex smartreflex.1: omap_sr_probe: SmartReflex driver initialized
>> [    2.423187] smartreflex smartreflex.2: omap_sr_probe: SmartReflex driver initialized
>> [    2.431732] SmartReflex Class3 initialized
>>
> Dumb question: how are you testing this? just boot log? or additional
> patch for DVFS?

Unfortunately, it is just a boot log since I do not have any DVFS code 
on top of it :-(

That's why I was not expecting any errors at that time.

Benoit
