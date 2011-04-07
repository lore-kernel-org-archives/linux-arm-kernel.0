From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 7 Apr 2011 05:59:14 +0200
Subject: [RFC 1/5]arch/arm/common/Makefile Remove unused config in the
	Makefile.
In-Reply-To: <20110406080522.GZ13963@pengutronix.de>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<20110406080522.GZ13963@pengutronix.de>
Message-ID: <20110407035914.GB29567@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:05 Wed 06 Apr     , Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Tue, Apr 05, 2011 at 09:58:18AM -0700, Justin P. Mattock wrote:
> > The patch below removes an unused config variable found by using a kernel
> > cleanup script.
> > Note: I did try to cross compile these but hit erros while doing so..
> > (gcc is not setup to cross compile) and am unsure if anymore needs to be done.
> > Please have a look if/when anybody has free time.
> > 
> > Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
> > CC: Russell King <linux@arm.linux.org.uk>
> > CC: linux-arm-kernel at lists.infradead.org
> The file was removed by commit
> 
> 	6d803ba (ARM: 6483/1: arm & sh: factorised duplicated clkdev.c)
> 
> (added the persons involved to Cc).
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
