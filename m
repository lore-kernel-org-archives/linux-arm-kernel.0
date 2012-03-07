From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 7 Mar 2012 09:18:55 -0300
Subject: I.MX35 PDK
In-Reply-To: <4F562C90.6090103@freescale.com>
References: <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A26@MEP-EXCH.meprolight.com>
 <4F562C90.6090103@freescale.com>
Message-ID: <CAOMZO5CyGazr1=kLF51W7S7ZpEy2Mg4k2n_ZHnGimSyu2oVcrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/6/12, Fabio Estevam <fabio.estevam@freescale.com> wrote:
> Alex Gershgorin wrote:
>> Hi Fabio,
>>
>>
>>
>> How I can get information about accesses to CMOS_RST_B and CSI_PWDN bits
>> of MC9S08DZ60 processor.
>>
>> I need address of this register and bits mapping in this register.

CMOS_RESET: Bit 6 of register 0x1a
CMOS_ENABLE: Bit 1 of register 0x20

After the mx35pdk lcd support patch gets applied I will submit a patch
to adding support to all of the registers/bits definitions for
mc9s08dz60 chip.

Regards,

Fabio Estevam
