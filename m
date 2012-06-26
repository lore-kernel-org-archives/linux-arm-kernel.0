From: hs@denx.de (Heiko Schocher)
Date: Tue, 26 Jun 2012 08:54:05 +0200
Subject: [PATCH v5 1/7] ARM: davinci, cp_intc: Add irq domain support
In-Reply-To: <4FE89CCB.4090609@ti.com>
References: <1338373143-7467-1-git-send-email-hs@denx.de>
 <1338373143-7467-2-git-send-email-hs@denx.de> <4FE89CCB.4090609@ti.com>
Message-ID: <4FE95C8D.4000505@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Sekhar,

On 25.06.2012 19:15, Sekhar Nori wrote:
> Hi Heiko,
>
> On 5/30/2012 3:48 PM, Heiko Schocher wrote:
>> Signed-off-by: Heiko Schocher<hs@denx.de>
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Sekhar Nori<nsekhar@ti.com>
>> Cc: Wolfgang Denk<wd@denx.de>
>> Cc: Sergei Shtylyov<sshtylyov@mvista.com>
>>
>> ---
>
> Applying this patch with two changes:
>
> 1) select IRQ_DOMAIN for CP_INTC arch/arm/mach-davinci/Kconfig. Without
> this build breaks.
>
> 2) Add some commit description. For future, please have some commit
> description on all patches.

Ok.

> I boot tested this on AM18x EVM. Also tested that GPIO interrupts are
> not broken.

Thanks!

BTW: What is with the "rest" of the patches in this patchset? I got no
      more comments for them.

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
