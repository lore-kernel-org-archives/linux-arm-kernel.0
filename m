From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Apr 2014 18:13:07 +0200
Subject: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
In-Reply-To: <20140414180142.0dd63a1f@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032> <20140414180142.0dd63a1f@skate>
Message-ID: <10589751.qhi630WAFs@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 14, 2014 06:01:42 PM Thomas Petazzoni wrote:
> Dear Bartlomiej Zolnierkiewicz,
> 
> On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> 
> > >  * Fixed the module alias name. Suggested by Bartlomiej
> > >    Zolnierkiewicz.
> > 
> > Well, you could have also added a comment explaining the lack of
> > the Power Management support..
> 
> True, sorry for this. Should I resend a new version of the patch series
> with an indication about this in the commit log? Or is this OK as it is?

Please include the comment in the next revision if this is not too much
trouble (I assume that you would like to do another re-spin just to add
Acked-by/Reviewed-by tags anyway).

> Note that working on power management support is part of our mid-term
> TODO list for this platform, so it will not remain unimplemented
> forever.

OK, good to hear that.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
