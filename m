From: broonie@kernel.org (Mark Brown)
Date: Fri, 8 Jan 2016 02:47:55 +0000
Subject: next boot: 564 boots: 59 failed, 448 passed with 57 offline
 (next-20160107)
In-Reply-To: <20160107185739.GA29951@kroah.com>
References: <568e8740.01941c0a.31072.ffffb67b@mx.google.com>
 <20160107155958.GG6588@sirena.org.uk> <20160107162810.GA25177@ulmo>
 <20160107185739.GA29951@kroah.com>
Message-ID: <20160108024755.GK6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 10:57:39AM -0800, Greg Kroah-Hartman wrote:
> On Thu, Jan 07, 2016 at 05:28:10PM +0100, Thierry Reding wrote:
> > On Thu, Jan 07, 2016 at 03:59:58PM +0000, Mark Brown wrote:

> > I think this is merely waiting to be picked up into the tty tree. I
> > suspect the reason why there's output in the first place is because
> > of earlyprintk. I've seen recent linux-next work properly, with the
> > serial console hanging at some point (fbcon shows login prompt). If
> > I apply the above patch things are back to normal.

> I'll go queue that up later, but how is this suddenly showing up in
> -next?  The tty tree has been pretty quiet for a while now..

There were some memory management issues which broke booting on almost
all ARM platforms for most of this week so nothing else was really
visible and relatively few -next builds over the Christmas vacation (as
one would expect).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160108/e4e9f71c/attachment-0001.sig>
