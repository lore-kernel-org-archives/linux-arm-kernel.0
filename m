From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Dec 2014 08:21:12 +0000
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
In-Reply-To: <5485E1EA.2070902@wwwdotorg.org>
References: <20141208120619.68287b54@canb.auug.org.au>
 <2406890.FlzRjyvuXd@wuerfel> <20141208130009.GL3951@x1>
 <3348703.0b5FTH9Sa3@wuerfel> <20141208134903.GN3951@x1>
 <5485CD02.7010903@wwwdotorg.org> <20141208165127.GP3951@x1>
 <5485E1EA.2070902@wwwdotorg.org>
Message-ID: <20141209082112.GQ3951@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 08 Dec 2014, Stephen Warren wrote:

> On 12/08/2014 09:51 AM, Lee Jones wrote:
> >On Mon, 08 Dec 2014, Stephen Warren wrote:
> ...
> >>The primary purpose of the kernel.org linux-rpi.git repo is for
> >>staging patches into arm-soc/linux-next. As such, just like any
> >>other similar repo, users should expect at least the for-xxx (e.g.
> >>for-next) branches to get reset as kernel versions tick over, in
> >>order to contain the content for the next kernel. Anyone using those
> >>branches for anything else (e.g. local development) simply has to be
> >>prepared to do a rebase themselves when that happens.
> >
> >I agree with this.
> >
> >>Equally, and patches that get sent to arm-soc should probably never
> >>be applied to linux-rpi.git; anything that gets applied to
> >>linux-rpi.git should get sent to arm-soc as a pull request. That
> >>avoids duplicate commits.
> >
> >I'm okay to follow this rule if my perception of the tree is changed.
> >The current view is that this repo can be used by engineers/hobbyists
> >as a single resource to pick up RPi patches which are yet to complete
> >their full transition into Mainline.
> >
> >Arnd and I had a discussion where I flagged my concerns about these
> >kinds of conflicts.  The outcome was that as long as the patches were
> >simple enough, then no conflict should arise.  Unfortunately this
> >turned out not to be quite true.
> >
> >So I'm happy with whatever.  Stephen, the repo is your concept.  I'll
> >play it however you want me to play it.  As the merge-window is now
> >open I'm going to eradicate rpi/for-next in any case.
> 
> Eradicate or reset? If you delete it, Stephen Rothwell will have a
> problem fetching it when creating linux-next. Usually to empty out
> the for-next branch, you'd reset it to some recent Linus tag; 3.18
> seems like a good one at present.

Yes, in this case eradicate == `git reset <blah>`.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
