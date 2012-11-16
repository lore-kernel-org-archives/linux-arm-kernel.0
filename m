From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 16 Nov 2012 17:13:30 +0000
Subject: [GIT PULL] arm-soc: Xilinx zynq changes for v3.8
In-Reply-To: <201211161654.23470.arnd@arndb.de>
References: <CAHTX3dLdGie9gtxbPq_gb8BLao7YYohqQWZFg3LzyNHxu=imdg@mail.gmail.com>
 <CAHTX3dLijLK45ddZQVYHcrs6QQbmdRmQbPmTKada9nXx3ZAe3w@mail.gmail.com>
 <201211161654.23470.arnd@arndb.de>
Message-ID: <52241ede-3d28-43fc-967d-36ab64d52592@CH1EHSMHS038.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Friday, November 16, 2012 5:54 PM
> To: Michal Simek
> Cc: arm at kernel.org; LKML; linux-arm; Olof Johansson; Nick Bowler; Josh
> Cartwright; John Linn
> Subject: Re: [GIT PULL] arm-soc: Xilinx zynq changes for v3.8
>
> On Friday 16 November 2012, Michal Simek wrote:
> > I have 7 new follow up patches for zynq. They are based on previous
> > patches (arm-soc zynq/cleanup branch).
> > The branch is still based on rc3 but I have also tried to merged it
> > with the v3.7-rc5 and there is no issue.
> >
> > It should be the last pull request for v3.8.
> >
>
> Pulled into next/dt, thanks!
>
> This was a small set of patches and you're new to the job, so there is no problem
> with what you sent me, but I have a few comments for the
> future:

Yeah, need to learn more how arm-soc works.

>
> * Please provide a description of the series that I can put into the merge
> changeset, either in the introductory mail or (better) into the signed tag that
> you send (git tag -s). Have a look at how Tony Lindgren does this, he writes the
> best descriptions.

No. Do you have a link?

> * I've used the next/dt branch, since that is what most of the patches from this
> series best fit in. However, some of the patches would have made more sense
> in a different branch (clock, cleanup, ...).
> When you have things that are logically separate, just send separate pull
> requests. This takes some practice to get the dependencies right, so please ask
> if you are not sure how to do it.

yeah. I forget.

> * It seems the zynq multiplatform changes didn't make it for 3.8. I hope you can
> do this for 3.9, as this should not be too hard.

We have done a lot of changes and I believe I will have more time to do it soon.

Thanks,
Michal


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
