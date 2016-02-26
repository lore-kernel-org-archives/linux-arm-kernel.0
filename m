From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 17:17 +0100
Subject: [RFT PATCH] arm: omap1_defconfig: convert to use libata PATA
 drivers
In-Reply-To: <6359194.rjne3vOG9H@amdc1976>
References: <1439571876-13758-1-git-send-email-b.zolnierkie@samsung.com>
 <20150817063454.GF4215@atomide.com> <6359194.rjne3vOG9H@amdc1976>
Message-ID: <14037681.WEvu3PZVCh@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 February 2016 15:16:10 Bartlomiej Zolnierkiewicz wrote:
> On Sunday, August 16, 2015 11:34:55 PM Tony Lindgren wrote:

> > > Build tested only.
> > > If you have affected hardware please test.  Thank you.
> > 
> > All my omap1 devices are in a rack using NFSroot or MMC so
> > I can't test this. Seems like a good idea to me thoug, and does
> > not cause merge conflicts. So if you want to queue this via
> > along with other PATA related patches, please feel free to
> > add:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Thank you.
> 
> Arnd/Olof, could you please merge this patch?
> 

Can you send the two patches in question again, and add arm at kernel.org
to Cc? I have trouble pulling them out of the archive at the moment.

	Arnd
