From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 24 Aug 2012 16:08:03 +0100
Subject: [alsa-devel] [PATCH 14/17] ARM: ux500: Rename MSP board file to
 something more meaningful
In-Reply-To: <1BAFE6F6C881BF42822005164F1491C33EA69B3A@DBDE01.ent.ti.com>
References: <1345816913-4113-1-git-send-email-lee.jones@linaro.org>
 <1345816913-4113-15-git-send-email-lee.jones@linaro.org>
 <1BAFE6F6C881BF42822005164F1491C33EA69B3A@DBDE01.ent.ti.com>
Message-ID: <20120824150802.GP32491@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >  arch/arm/mach-ux500/Makefile             |    2 +-
> >  arch/arm/mach-ux500/board-mop500-audio.c |  199 ++++++++++++++++++++++++++++++
> >  arch/arm/mach-ux500/board-mop500-msp.c   |  199 ------------------------------
> 
> Please use _M option when generating patches (git-format-patch -M ...).
> This will reduce the final patch size

Ah, I see. That's what Linus was going on about!

I can do that.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
