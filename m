From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 15 Jul 2011 17:46:36 +0200
Subject: [PATCH 4/7] at91: remove non used at91_spi.h
In-Reply-To: <4E2028E1.1060603@vollmann.ch>
References: <1310687525-22486-1-git-send-email-plagnioj@jcrosoft.com>
	<1310687525-22486-4-git-send-email-plagnioj@jcrosoft.com>
	<4E2028E1.1060603@vollmann.ch>
Message-ID: <20110715154636.GA20678@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:47 Fri 15 Jul     , Detlef Vollmann wrote:
> Sorry, I couldn't find a summary message for this patch series,
> so I picked this one to reply, because this one hurts me most.
> 
> On 07/15/11 01:52, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD<plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre<nicolas.ferre@atmel.com>
> > ---
> >   arch/arm/mach-at91/include/mach/at91_spi.h |   81
> ----------------------------
> >   1 files changed, 0 insertions(+), 81 deletions(-)
> >   delete mode 100644 arch/arm/mach-at91/include/mach/at91_spi.h
> [...]
> 
> First, I'm actually using mach/at91_spi.h in an SPI slave driver.
> And I'm using arch/arm/mach-at91/include/mach/at91_spi.h instead of
> drivers/spi/atmel_spi.h (which still exists in the kernel version
> we use here), because arch/arm/mach-at91/include/mach/at91_spi.h
> is accessible from an out-of-tree driver w/o extra effort.
> 
> And this applies to all all of those header files, so I'm
> really against all patches in this series.
You need the use SPI framework for this

Out of tree driver is not enough good reason to keep it

Best Regards,
J.
