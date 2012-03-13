From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 13 Mar 2012 09:51:59 +0100
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <1331500100-31351-4-git-send-email-robherring2@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <1331500100-31351-4-git-send-email-robherring2@gmail.com>
Message-ID: <CACRpkda=WDTkSAwF8TYWfhnSX_FjJDwzKRhcuk6=pn9j96Eu=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 11, 2012 at 10:08 PM, Rob Herring <robherring2@gmail.com> wrote:

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

Acked-by: Linus Walleij <linus.walleij@linaro.org>

For:

> ?arch/arm/mach-u300/include/mach/u300-regs.h ? ? | ? ?6 ------

Yours,
Linus Walleij
