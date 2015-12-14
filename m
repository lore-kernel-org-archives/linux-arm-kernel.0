From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 14 Dec 2015 09:13:26 +0100
Subject: [PATCH v10 2/2] arm-soc: Add support for tango4 platforms
In-Reply-To: <7573032.IeyxZFmjBm@wuerfel>
References: <56549B3A.8010703@sigmadesigns.com>
 <5654A0F3.40404@sigmadesigns.com> <56558E41.7050301@sigmadesigns.com>
 <7573032.IeyxZFmjBm@wuerfel>
Message-ID: <566E7A26.50004@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/12/2015 00:14, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 11:32:33 Marc Gonzalez wrote:
>> On 24/11/2015 18:40, Marc Gonzalez wrote:
>>
>>> +config ARCH_TANGO
>>> +     bool "Sigma Designs Tango4 (SMP87xx)" if ARCH_MULTI_V7
>>> +     # Cortex-A9 MPCore r3p0, PL310 r3p2
>>> +     select ARCH_HAS_HOLES_MEMORYMODEL
>>> +     select ARM_ERRATA_754322
>>> +     select ARM_ERRATA_764369 if SMP
>>> +     select ARM_ERRATA_775420
>>> +     select ARM_GIC
>>> +     select CLKSRC_TANGO_XTAL
>>> +     select GENERIC_IRQ_CHIP
>>
>> Instead of GENERIC_IRQ_CHIP, I should select TANGO_IRQCHIP
>> (to be defined in drivers/irqchip/Kconfig)
>>
>> TANGO_IRQCHIP itself will select IRQ_DOMAIN and GENERIC_IRQ_CHIP.
>>
> 
> Are you sending a V11 with this?

Yep, v11 coming up later today.

Thanks for reminding me.

Regards.
