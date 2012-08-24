From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 24 Aug 2012 09:09:07 +0800
Subject: [PATCH 1/6] gpio/mxs: adopt irq_domain support for mxs gpio driver
In-Reply-To: <CACRpkdbSaa6ZOZYB1Cm7WjW0O51kvwsTAxhjefEKd-7XaBB3dw@mail.gmail.com>
References: <1345472400-31262-1-git-send-email-shawn.guo@linaro.org>
 <1345472400-31262-2-git-send-email-shawn.guo@linaro.org>
 <CACRpkdbSaa6ZOZYB1Cm7WjW0O51kvwsTAxhjefEKd-7XaBB3dw@mail.gmail.com>
Message-ID: <20120824010904.GN24242@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 23, 2012 at 11:49:50PM +0200, Linus Walleij wrote:
> On Mon, Aug 20, 2012 at 4:19 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Remove irq_domain_add_legacy call from mach-mxs.c and have the gpio
> > driver adopt irqdomain support, so that we can have the mapping
> > between gpio and irq number available without using virtual_irq_start
> > and MXS_GPIO_IRQ_START.
> >
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> 
> OK patch applied, thanks!
> 
I was planning to have the patch to go via arm-soc tree with your ACK.
But it also works to have it on gpio tree and I ask arm-soc people to
pull gpio tree into arm-soc, but you need to ensure the branch is
stable (no rebase).

-- 
Regards,
Shawn
