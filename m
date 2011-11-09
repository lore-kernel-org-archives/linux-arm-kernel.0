From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Nov 2011 16:16:37 -0200
Subject: [PATCH v2] ARM: arch.h: Declare 'pt_regs' locally
In-Reply-To: <20111109175635.GO12913@n2100.arm.linux.org.uk>
References: <1320840648-3197-1-git-send-email-fabio.estevam@freescale.com>
 <20111109175635.GO12913@n2100.arm.linux.org.uk>
Message-ID: <CAOMZO5B+7x964OkKwTeZG=aA_VhdYtzbvaEUKqCZZ1+2wdF5tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2011 at 3:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 09, 2011 at 10:10:48AM -0200, Fabio Estevam wrote:
>> Fix the following warning when building imx_v4_v5_defconfig target:
>>
>> ? CC ? ? ?arch/arm/mach-imx/mach-imx27ipcam.o
>> In file included from arch/arm/mach-imx/mach-imx27ipcam.c:18:
>> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: 'struct pt_regs' declared inside parameter list
>> /home/fabio/linus/linux-2.6/arch/arm/include/asm/mach/arch.h:47: warning: its scope is only this definition or declaration, which is probably not what you want
>> arch/arm/mach-imx/mach-imx27ipcam.c:78: warning: initialization from incompatible pointer type
>>
>> Declare 'struct pt_regs' locally.
>>
>> Cc: Eric Miao <eric.miao@canonical.com>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> Yup. ?Can go to the patch system, thanks.

Done as 7155/1.

Regards,

Fabio Estevam
