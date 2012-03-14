From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 14 Mar 2012 15:11:16 +0800
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
Message-ID: <CAN1soZwAq8yDc2ka8hPUme9WM-fw4XRV6bAVEabgndFLA1fmoQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2012 at 5:08 AM, Rob Herring <robherring2@gmail.com> wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Several platforms create IOMEM defines for casting to 'void __iomem *',
> and other platforms are incorrectly using __io() macro for the same
> purpose. This creates a common definition and removes all the platform
> specific versions. Rather than try to make linux/io.h and asm/io.h
> assembly safe, the assembly version of IOMEM is moved into
> asm/assembler.h.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
>
> ?arch/arm/mach-mmp/include/mach/addr-map.h ? ? ? | ? ?6 ------

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
