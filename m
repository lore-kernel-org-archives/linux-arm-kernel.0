From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 17 Oct 2011 12:15:32 +0200
Subject: [PATCH] AT91: Add external RTC for Flexibity board
In-Reply-To: <20111013211145.GA27779@n2100.arm.linux.org.uk>
References: <4DC53134.8070706@gmail.com>
	<20110510234526.GC18929@game.jcrosoft.org>
	<BANLkTikvCiXgnm_hVTqDmzZ6yDf6H5WaCw@mail.gmail.com>
	<20111013211145.GA27779@n2100.arm.linux.org.uk>
Message-ID: <20111017101532.GU1459@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22:11 Thu 13 Oct     , Russell King - ARM Linux wrote:
> On Wed, May 11, 2011 at 09:44:52AM +0200, Andrew Victor wrote:
> > hi,
> > 
> > >> This patch enables external RTC support on AT91 Flexibity board.
> > 
> > Acked-by: Andrew Victor <linux@maxim.org.za>
> > 
> > Maxim: You can submit it to Russell's patch system.
> > 
> > 
> > > looks fine just one comment please add your board to the new at91sam9260_defconfig
> > 
> > That file does not exist in any mainline kernel.
> 
> It's been a while since this patch went into the patch system, and it
> didn't get applied for various reasons, including because it looked
> like it was sent there without any review (no acked-by's etc added to
> it.)
> 
> What's the status of this - and if its still relevant can we have
> it with the proper attributations please
This patch is already in Arnd tree IIRC

Best Regards,
J.
