From: ben@trinity.fluff.org (Ben Dooks)
Date: Wed, 11 Aug 2010 00:44:18 +0100
Subject: [PATCH 0/6] i2c: davinci updates for 2.6.35
In-Reply-To: <AANLkTinNXxzCoH+b3=xA92sW8GCqqO4iY+_yVwBFLMqG@mail.gmail.com>
References: <1270575738-22388-1-git-send-email-khilman@deeprootsystems.com>
	<20100420000621.GK32401@fluff.org.uk>
	<AANLkTikJ6XDywcBA5O0mC85jQEIWxZ9NOALIQOjcGCDJ@mail.gmail.com>
	<AANLkTinNXxzCoH+b3=xA92sW8GCqqO4iY+_yVwBFLMqG@mail.gmail.com>
Message-ID: <20100810234417.GA28671@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 08:56:27AM -0700, Kevin Hilman wrote:
> Ben,
> 
> On Mon, Jun 21, 2010 at 1:16 PM, Kevin Hilman
> <khilman@deeprootsystems.com> wrote:
> > On Mon, Apr 19, 2010 at 5:06 PM, Ben Dooks <ben-linux@fluff.org> wrote:
> >> On Tue, Apr 06, 2010 at 10:42:12AM -0700, Kevin Hilman wrote:
> >>> This series of davinci I2C driver updates and fixes is targetted for
> >>> 2.6.35. ?It has been tested in davinci git on multiple davinci SoCs.
> >>>
> >>> Ben, since these changes are isolated to the davinci driver only, if
> >>> you prefer I can merge them upstream along with my davinci changes for
> >>> 2.6.35.
> >>
> >> I'll get them into -next when I rebase it.
> >
> > Ben, this series never made it in for 2.6.35.
> >
> > I've now rebased this against v2.6.35-rc3 and it's available here:
> >
> > ? git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git
> > davinci-i2c
> >
> > Please pull for 2.6.36. ?Thanks.
> 
> OK, it's now been two merge windows that these have been
> ignored/forgotten.  Can you let me know what is the plan for these?

pulled into current i2c-next, will send in the next day or so.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
