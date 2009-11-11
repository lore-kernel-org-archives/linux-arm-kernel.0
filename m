From: ben-linux@fluff.org (Ben Dooks)
Date: Wed, 11 Nov 2009 23:01:57 +0000
Subject: [PATCH] ARM: SAMSUNG: Add plat-samsung as starting point for
	plat-s3c* moves
In-Reply-To: <9c9fda240911110031x5fd0e2f1sefc1edbc8cda4d@mail.gmail.com>
References: <1257812406-17360-1-git-send-email-ben-linux@fluff.org>
	<000a01ca61a5$c573d000$505b7000$%kim@samsung.com>
	<9c9fda240911091927m46ed0fccyfbbc8873eb9c5da9@mail.gmail.com>
	<20091110094756.GN4048@prithivi.gnumonks.org>
	<000001ca620b$2141c080$63c54180$%szyprowski@samsung.com>
	<20091111045835.GO4047@prithivi.gnumonks.org>
	<9c9fda240911110031x5fd0e2f1sefc1edbc8cda4d@mail.gmail.com>
Message-ID: <20091111230156.GK4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2009 at 05:31:24PM +0900, Kyungmin Park wrote:
> On Wed, Nov 11, 2009 at 1:58 PM, Harald Welte <laforge@gnumonks.org> wrote:
> > Hi Marek,
> We are waiting too much time. but nothing are change. As you mentioned
> you and ben try to change frameworks and directories. However we did a
> lot of works already. but your changes make it works twice since to
> match framework changes

Hey, if this stuff had been done earlier by any of the Samsung groups
then we'd be at a state where the changes would have been done to inline
code.

I hope that a lot of these changes will not only improve the code but
will be in such a way that simply editing the unsubbmitted/inprogress
architectures will not be difficult. I hope that some of these changes
will have quite a bit of the work scripted and thus fixups will be far
less painful. I also to intend not only to document the patches properly
but write some in-kernel documentation for the new systems so that it
can be referenced by developers looking at what changed.

There will be effort to ensure that these changes are not mandatory to
proper kernel operation.

You need to remember that I am doing this _in my spare time_ and thus
cannot devote the sort of time to this code that other people would
like. Hopefully the device changes (progressing) and clock changes
will be published during this weekend for people to review.

The actual change in directory structure may take more than this round
of kernel submissions. Our first aim is to factor out as much common
code as possible into plat-samung and deal with any fall out from these
changes.

> The point of view are different, you and LSI focuses on 64xx series
> but I don't interest these SoCs. Since we are focusing on s5pc1xx
> series whatever S5PV210 is.
> Also I can't find any activities at ben's git or LSI git. Where's your
> works and plan?

Currently in progress, 
 
> If you want to change, please also change the s5pc1xx that merged at mainline.

I will ensure all current defconfigs at-least build. I will throw the
autobuilder at it to see what is going on.

If someone can ensure that my last set of comments is replied to for the
S5PC merges sent by Marek, then I may consider merging as many of those
as possible (and at minimum the ones that will be affected by the changes).
 
> Thank you,
> Kyungmin Park
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
