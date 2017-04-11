From: juri.lelli@arm.com (Juri Lelli)
Date: Tue, 11 Apr 2017 11:43:37 +0100
Subject: [PATCH v3 6/9] drivers: remove useless comment from
 base/arch_topology.c
In-Reply-To: <20170410163325.GU17774@n2100.armlinux.org.uk>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-7-juri.lelli@arm.com>
 <20170410135103.GR17774@n2100.armlinux.org.uk>
 <20170410140214.GE30804@e106622-lin>
 <20170410163325.GU17774@n2100.armlinux.org.uk>
Message-ID: <20170411104337.GP30804@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/17 17:33, Russell King - ARM Linux wrote:
> On Mon, Apr 10, 2017 at 03:02:14PM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > On 10/04/17 14:51, Russell King - ARM Linux wrote:
> > > On Mon, Mar 27, 2017 at 02:18:22PM +0100, Juri Lelli wrote:
> > > > Printing out an error message when we failed to get the cpu device is
> > > > not helping anyone. Remove it.
> > > 
> > > (1) the subject line talks about removing a "comment" but you're
> > >     actually removing an error printk
> > > (2) I don't think it's "not helping anyone", although the description
> > >     above doesn't say _why_ - it's reporting the lack of a missing CPU
> > >     device that we expect to be present.  If it's not present, then
> > >     we're not going to end up with the cpu capacity attribute, and the
> > >     error message answers the "why is that sysfs file missing" question.
> > 
> > That's the same I was thinking when I put the error message there in the
> > first place. But, then Greg didn't seem to like it.
> 
> I don't think it was a case of "not liking it" - Greg asked what use it
> was.  Greg also pointed out the race with userspace.
> 

Right. I asked him for more information, since I wasn't able to
understand where the problem is.

> I think dropping this patch is the quickest way to move forward.
> 

OK, I'm also up for dropping it.

Best,

- Juri
