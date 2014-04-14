From: tj@kernel.org (Tejun Heo)
Date: Mon, 14 Apr 2014 13:46:06 -0400
Subject: [PATCH v2 0/5] Support for Marvell AHCI interface on Armada 38x
In-Reply-To: <20140414181920.1e309019@skate>
References: <1397486055-16303-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <16639486.i0jTGsaDYr@amdc1032> <20140414180142.0dd63a1f@skate>
 <10589751.qhi630WAFs@amdc1032> <20140414181920.1e309019@skate>
Message-ID: <20140414174606.GB10416@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 14, 2014 at 06:19:20PM +0200, Thomas Petazzoni wrote:
> Dear Bartlomiej Zolnierkiewicz,
> 
> On Mon, 14 Apr 2014 18:13:07 +0200, Bartlomiej Zolnierkiewicz wrote:
> > On Monday, April 14, 2014 06:01:42 PM Thomas Petazzoni wrote:
> > > Dear Bartlomiej Zolnierkiewicz,
> > > 
> > > On Mon, 14 Apr 2014 17:53:37 +0200, Bartlomiej Zolnierkiewicz wrote:
> > > 
> > > > >  * Fixed the module alias name. Suggested by Bartlomiej
> > > > >    Zolnierkiewicz.
> > > > 
> > > > Well, you could have also added a comment explaining the lack of
> > > > the Power Management support..
> > > 
> > > True, sorry for this. Should I resend a new version of the patch series
> > > with an indication about this in the commit log? Or is this OK as it is?
> > 
> > Please include the comment in the next revision if this is not too much
> > trouble (I assume that you would like to do another re-spin just to add
> > Acked-by/Reviewed-by tags anyway).
> 
> Well, I wasn't planning on re-spinning just to add Acked-by/Reviewed-by
> tags, as those are generally added by the subsystem maintainers when
> applying the patches. Though if Tejun says otherwise, I can definitely
> re-spin without any problem.
> 
> Tejun, just let me know what you prefer.

I can collect the -by's but better patch description is always nice.
Maybe just update the patch description and post that one as reply to
the patch posted in this thread?  Also, how do you want the patches to
be routed?  Can all go through libata?

-- 
tejun
