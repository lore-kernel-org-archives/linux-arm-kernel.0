From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 5 Jul 2011 07:37:50 +0200
Subject: [PATCH 2/8] at91: factorize at91 interrupts init to soc
In-Reply-To: <20110704091931.GB5509@taskit.de>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
	<1309502682-16897-2-git-send-email-plagnioj@jcrosoft.com>
	<20110704091931.GB5509@taskit.de>
Message-ID: <20110705053750.GD27909@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11:19 Mon 04 Jul     , Christian Glindkamp wrote:
> On 2011-07-01 08:44, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > they are the same except the default priority
> > 
> > Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> > Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> > Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> > ---
> >  arch/arm/mach-at91/board-gsia18s.c      |    5 -----
> >  arch/arm/mach-at91/board-pcontrol-g20.c |    7 -------
> >  arch/arm/mach-at91/board-stamp9g20.c    |    6 ------
> 
> Aren't you breaking these boards? You remove their init_irq function
> without updating the machine structure.
good catch

Best Regards,
J.
