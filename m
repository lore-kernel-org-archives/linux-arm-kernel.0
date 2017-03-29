From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Thu, 30 Mar 2017 09:29:09 +1100
Subject: Including Alpine -next tree in linux-next
In-Reply-To: <20170329132148.fzn4pxc4523os4y7@kwain>
References: <20170329131201.j4e7cnmgufj2i7tr@kwain>
 <20170330001444.62ac2ad1@canb.auug.org.au>
 <20170329132148.fzn4pxc4523os4y7@kwain>
Message-ID: <20170330092902.49cb4d4f@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Wed, 29 Mar 2017 15:21:48 +0200 Antoine Tenart <antoine.tenart@free-electrons.com> wrote:
>
> On Thu, Mar 30, 2017 at 12:14:54AM +1100, Stephen Rothwell wrote:
> > On Wed, 29 Mar 2017 15:12:01 +0200 Antoine Tenart <antoine.tenart@free-electrons.com> wrote:  
> > >
> > > Hello Eric,  
> > 
> > Who is this "Eric" person? ;-)  
> 
> My apologies. I completely messed up my copy-and-paste I guess... Of
> course I meant "Stephen" :)

No worries :-)

> > > Would it be possible to include Alpine's -next tree in linux-next?
> > > 
> > > Repo: https://git.kernel.org/pub/scm/linux/kernel/git/atenart/linux.git
> > > Branch: alpine/for-next  
> > 
> > Could you give me a short idea about what this tree contains?  Also,
> > whose tree will it be merged via (or does it go direct to Linus
> > (Torvalds)?  
> 
> The Alpine SoCs are ARM and ARM64 processors. This branch will contain
> patches we plan to send to arm-soc during their merge window. So mostly
> device tree and SoC specific patches.
> 
> The patches will be merged through arm-soc before getting to Linus.

Included from today with just you as the contact.

Thanks for adding your subsystem tree as a participant of linux-next.  As
you may know, this is not a judgement of your code.  The purpose of
linux-next is for integration testing and to lower the impact of
conflicts between subsystems in the next merge window. 

You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and 
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary.

-- 
Cheers,
Stephen Rothwell 
sfr at canb.auug.org.au
