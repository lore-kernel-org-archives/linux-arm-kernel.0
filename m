From: dwalker@fifo99.com (Daniel Walker)
Date: Tue, 06 Apr 2010 15:44:04 -0700
Subject: [GIT PULL] generic arm for MSM
In-Reply-To: <0D753D10438DA54287A00B0270842697636D1FD94C@AUSP01VMBX24.collaborationhost.net>
References: <1269557364.21793.52.camel@c-dwalke-linux.qualcomm.com>
	<20100325225300.GK24984@n2100.arm.linux.org.uk>
	<1269557655.21793.53.camel@c-dwalke-linux.qualcomm.com>
	<20100325225555.GL24984@n2100.arm.linux.org.uk>
	<1269559307.21793.78.camel@c-dwalke-linux.qualcomm.com>
	<20100326081445.GB20553@pengutronix.de>
	<20100326082300.GA6665@n2100.arm.linux.org.uk>
	<1270163491.16695.27.camel@c-dwalke-linux.qualcomm.com>
	<20100406213532.GC12831@n2100.arm.linux.org.uk>
	<1270591225.9066.52.camel@c-dwalke-linux.qualcomm.com>
	<20100406220418.GD12831@n2100.arm.linux.org.uk>
	<1270591732.9066.54.camel@c-dwalke-linux.qualcomm.com>
	<0D753D10438DA54287A00B0270842697636D1FD94C@AUSP01VMBX24.collaborationhost.net>
Message-ID: <1270593844.9066.57.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2010-04-06 at 17:34 -0500, H Hartley Sweeten wrote:
> On Tuesday, April 06, 2010 3:09 PM, Daniel Walker wrote:
> > On Tue, 2010-04-06 at 23:04 +0100, Russell King - ARM Linux wrote:
> >>  
> >>> Does you server list anything wrong happening, cause those 550 errors
> >>> seem pretty suspect. It could also be some sort of firewall thing on my
> >>> end. I'm assuming no one else has reported anything like this before
> >>> right?
> >> 
> >> The 550 errors are because the unpacked objects don't exist; they're
> >> already inside one of Linus' pack files which you should already have.
> >> 
> >> That's the point - you should already have these git IDs (the ones you
> >> explicitly refer to) so there should be no reason for git to even
> >> consider fetching them via http or ftp.
> >
> > So your saying that the git defect .. I'm using a fairly recent version
> > of git 1.7.0 .. There are slightly more recent ones which I can try
> > also.
> 
> Daniel,
> 
> I just updated my copy of Russell's tree with no issues:
> 
>  $ git remote update
> Fetching origin
> Fetching linux-arm
> From http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/linux-2.6-arm
>    988addf..b72c409  devel-stable -> linux-arm/devel-stable
>  * [new branch]      lmb        -> linux-arm/lmb
>    bb45692..c6c3523  master     -> linux-arm/master
>    ae6be51..2eaa9cf  origin     -> linux-arm/origin
> 
> Are you trying to 'git pull' his tree?

No, it's remote so I do either "git fetch rmk" , or "git remote update
rmk"

> I tried that initially and it worked fine for the initial pull.  After that I
> always ran into issues with trying to update it.
> 
> I don't quite remember how I did the initial pull when I started a new branch
> to follow Russell's tree but I think I did it like the FAQ says on how to
> follow the -next tree.
> 
> Oh, this is using git version 1.7.0.3.254.g4503b

Did you ever try this on 1.7.0 ?

Daniel
