From: pavel@ucw.cz (Pavel Machek)
Date: Fri, 19 Oct 2018 00:15:49 +0200
Subject: omap4: support for manually updated display
In-Reply-To: <20180910174453.GV5662@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon> <20180910174453.GV5662@atomide.com>
Message-ID: <20181018221549.GB6364@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I want to make it clear that I don't want to claim any privilege in getting 
> > patches merged first. I am however worried that, without an easy way to test 
> > DSI support, and without enough time to focus on it, I would break whatever 
> > would be merged now in future reworks. I would thus like to find out how to 
> > collaborate on this task, hopefully to move towards usage of drm_bridge and 
> > drm_panel for DSI-based pipelines.
> 
> Real users with mainline kernel with a real product should
> always have priority over any ongoing clean-up.
> 
> And for testing, a bunch of real users is something you can't
> beat for proper testing of code on ongoing basis!
> 
> Naturally the burden of getting the patches ready is on the people
> using them for rebase and fixing comments. And Sebastian has
> already agreed help with maintaining it.
> 
> I've been actually using DSI command mode support and testing
> Linux next several times a week to prevent regressions from
> sneaking into -rc1 in general. So now I can't test omapdrm with
> next until Sebastian is done with rebasing.. Back to headless
> testing then.
> 
> Anyways, I'd say let's add the DSI command mode support ASAP after
> rebasing, there are at least Sebastian, Pavel and I then testing
> and helping with further ongoing panel conversion work.

Are there any news here? Does someone have a patch set that actually
works?

Are there any in-progress patches I could help with?

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181019/e7b5e3f2/attachment.sig>
