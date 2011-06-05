From: davem@davemloft.net (David Miller)
Date: Sun, 05 Jun 2011 14:06:57 -0700 (PDT)
Subject: [PATCH] ep93xx-eth: convert to phylib
In-Reply-To: <201106052029.24742.f.fainelli@gmail.com>
References: <201106051957.36492.florian@openwrt.org>
	<201106052029.24742.f.fainelli@gmail.com>
Message-ID: <20110605.140657.1039864716002412071.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 5 Jun 2011 20:29:24 +0200

> On Sunday 05 June 2011 19:57:36 Florian Fainelli wrote:
>> ep93xx-eth lacked support for monitoring link status changes, with this
>> patch, link changes are now watched and reported correctly.
>> 
>> Signed-off-by: Florian Fainelli <florian@openwrt.org>
>> ---
> 
> I just stumbled upon: http://www.mail-
> archive.com/netdev at vger.kernel.org/msg62549.html
> which does not seem to have been merged.
> 
> I will respin my patch with Herbert's changes

If people wonder why things don't get merged in situations like
this it's because there is no clear person standing up to act as
a maintainer.

Instead there are several different people submitting changes to
this one driver and I haven't got a clue who is authoritative and
who is not.

So 9 times out of ten I'm not going to merge anything submitted
in this way unless I start to see lots of ACKs from other developers.

When it gets to the point where multiple people are touching the
driver in all sorts of ways, there needs to be someone to do all of
the merging and making sure the patches get applied in the right order
and handling merge conflicts handled properly.  Then they submit them
formally here as a sane single set of patches to the list.

So who is going to step up and be the ep93xx-eth maintainer?  Lennert
is listed in MAINTAINERS, but I see little to no activity from him.

The last ACK Lennert gave for a patch to this driver was in May 2010,
more than a year ago.
