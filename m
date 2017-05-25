From: juri.lelli@arm.com (Juri Lelli)
Date: Thu, 25 May 2017 14:30:34 +0100
Subject: [PATCH v4 0/8] Fix issues and factorize arm/arm64 capacity
 information code
In-Reply-To: <20170525131831.GF16244@kroah.com>
References: <20170420144316.15632-1-juri.lelli@arm.com>
 <20170511084830.rn32pvi6weej2cna@e106622-lin>
 <20170511085952.GA6934@kroah.com>
 <20170511102718.qy54ajkzphasymhr@e106622-lin>
 <20170524144515.nuccflbdashlqmcs@e106622-lin>
 <20170525131831.GF16244@kroah.com>
Message-ID: <20170525133034.xeyzbl327af6y5zo@e106622-lin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/17 15:18, Greg KH wrote:
> On Wed, May 24, 2017 at 03:45:15PM +0100, Juri Lelli wrote:
> > Hi,
> > 
> > On 11/05/17 11:27, Juri Lelli wrote:
> > > On 11/05/17 10:59, Greg KH wrote:
> > > > On Thu, May 11, 2017 at 09:48:30AM +0100, Juri Lelli wrote:
> > > > > Hi Greg,
> > > > > 
> > > > > I'm not sure what your plans are with this set. Are we targeting 4.12?
> > > > > 
> > > > > IMHO, if possible, it would be good to have this refactoring in now, so
> > > > > that we can base further development on it for the next cycle.
> > > > 
> > > > It's way too late for new features that have not been in linux-next for
> > > > a few weeks, to get merged into 4.12-rc1, sorry.  I'll review this
> > > > patchset after -rc1 is out, and I get a chance to catch up on pending
> > > > patches.
> > > > 
> > > 
> > > Thanks for your reply, I perfecly understand.
> > > 
> > > OK, let's target 4.13 then. Looking forward to receive your comments
> > > after -rc1 is out.
> > > 
> > 
> > Did you have any chance to have a look at this set?
> 
> Now reviewed.  Looks fine except for the final names in the last patch,
> naming is hard, I know :)
> 

Thanks!

Just skimmed through your comments on 8/8. I'll address them in the next
few days and post again.

Best,

- Juri
