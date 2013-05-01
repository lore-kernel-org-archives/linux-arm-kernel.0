From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 1 May 2013 15:28:41 +0100
Subject: [PATCH 08/32 v2] dmaengine: ste_dma40: Remove home-brew MAX()
 macro
In-Reply-To: <CACRpkdaaa+gmsimkJVmhwv+zE+4ZmgZQ=AtHPry9=_EMScMC=w@mail.gmail.com>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
 <1366279934-30761-9-git-send-email-lee.jones@linaro.org>
 <20130424084912.GH17416@gmail.com>
 <CACRpkdaaa+gmsimkJVmhwv+zE+4ZmgZQ=AtHPry9=_EMScMC=w@mail.gmail.com>
Message-ID: <20130501142841.GF25256@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > The current implementation of the DMA40's local MAX() macro evaluates
> > its arguments more times than is necessary and it not type checked.
> > This patch strips replaces it with a new, more efficient constant.
> >
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Reported-by: Harvey Harrison <harvey.harrison@gmail.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Ah this v2 version is OK, atleast it makes the kernel look nicer.
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Vinod, poke.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
