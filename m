From: horms@verge.net.au (Simon Horman)
Date: Thu, 25 Jul 2013 22:23:19 +0900
Subject: [PATCH v2 1/3] ARM: shmobile: marzen: Switch to DT_MACHINE_START
In-Reply-To: <51F140C8.8070802@cogentembedded.com>
References: <1374718423-24230-1-git-send-email-horms+renesas@verge.net.au>
 <1374718423-24230-2-git-send-email-horms+renesas@verge.net.au>
 <51F140C8.8070802@cogentembedded.com>
Message-ID: <20130725132319.GC30895@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 07:14:16PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-07-2013 6:13, Simon Horman wrote:
> 
> >From: Magnus Damm <damm@opensource.se>
> 
>    Don't think it makes sense to keep Magnus as an author with so
> many of your added changes. But well, it's your decision...

I am comfortable with things the way they are so long as Magnus is too.

> >Convert the marzen board to use DT_MACHINE_START. With this in
> >place all mach-shmobile boards use DT_MACHINE_START. Also, this
> >makes it possible for the r8a7779 SMP code to use DT for CPUs.
> 
> >So appended DTB is the way forward on this board.
> 
> >Signed-off-by: Magnus Damm <damm@opensource.se>
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> >v2 [Simon Horman]
> >* Select USE_OF in Kconfig
> >* Provide dt_compat in DT_MACHINE_START
> >* Provide r8a7779-marzen dts
> 
> >v1 [Magnus Damm]
> >---
> >  arch/arm/boot/dts/Makefile            |  1 +
> >  arch/arm/boot/dts/r8a7779-marzen.dts  | 27 +++++++++++++++++++++++++++
> 
>    Perhaps arch/arm/boot/dts/ changes should be put into a separate patch?

That sounds reasonable.
