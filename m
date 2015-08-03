From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Aug 2015 10:09:51 +0100
Subject: [RFC 2/3] arm64: refactor save_stack_trace()
In-Reply-To: <20150720162004.GL9908@arm.com>
References: <12F47692-3010-4886-B87D-3D7820609177@gmail.com>
 <20150716113115.45a17f17@gandalf.local.home>
 <20150716121658.7982fdf5@gandalf.local.home>
 <20150717124054.GE26091@leverpostej>
 <20150717090009.720f6bd0@gandalf.local.home>
 <77EA0F10-D5F6-48BD-8652-3B979A978659@gmail.com>
 <20150717104144.6588b2f7@gandalf.local.home>
 <0886A996-40E1-49E9-823C-85E55A858716@gmail.com>
 <1357EA74-B972-4B99-ADB0-BC7E8F06DDB5@gmail.com>
 <20150720162004.GL9908@arm.com>
Message-ID: <20150803090951.GA10501@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On Mon, Jul 20, 2015 at 05:20:04PM +0100, Will Deacon wrote:
> On Fri, Jul 17, 2015 at 04:34:21PM +0100, Jungseok Lee wrote:
> > On Jul 17, 2015, at 11:59 PM, Jungseok Lee wrote:
> > > On Jul 17, 2015, at 11:41 PM, Steven Rostedt wrote:
> > >> Thanks! Can you repost patch 1 with the changes I recommended, so that
> > >> I can get an Acked-by from the arm64 maintainers and pull all the
> > >> changes in together. This is fine for a 4.3 release, right? That is, it
> > >> doesn't need to go into 4.2-rcs.
> > >> 
> > > 
> > > It's not hard to repost a patch, but I feel like we have to wait for Akashi's response.
> > > Also, it might be needed to consider Mark's comment on arch part.
> > > 
> > > If they are okay, I will proceed.
> > 
> > The [RFC 1/3] patch used in my environment is shaped as follows.
> > I leave the hunk for *only* clear synchronization. This is why I choose this format
> > instead of reposting a patch. I hope it would help to track down this thread.
> > 
> > I think this is my best at this point.

[...]

> The arm64 bits look fine to me:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

What happened to this? Is it queued someplace, or are we waiting for a
new version?

Will
