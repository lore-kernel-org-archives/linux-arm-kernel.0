From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 13:02:55 +0200
Subject: [PATCH v2] drivers: firmware: psci: unify enable-method binding
 on ARM {64, 32}-bit systems
In-Reply-To: <20160426110147.GC20836@leverpostej>
References: <1461338282-19509-1-git-send-email-sudeep.holla@arm.com>
 <31757054.8aSO57qemx@wuerfel> <20160426110147.GC20836@leverpostej>
Message-ID: <5255940.mPUzGZ0TLa@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 April 2016 12:01:48 Mark Rutland wrote:
> On Tue, Apr 26, 2016 at 12:49:00PM +0200, Arnd Bergmann wrote:
> > On Tuesday 26 April 2016 11:42:58 Sudeep Holla wrote:

> > > 
> > > Gentle ping to include this in next round of arm-soc fixes. It would be
> > > good to get this fixed before v4.6 as we don't want to have user of the
> > > binding which we want to remove in the release.
> > > 
> > 
> > Applied to the fixes branch. I have to admit that I don't understand
> > how the compatible string is really used here, so I have to trust that
> > this cannot break any existing machine.
> 
> The buggy code was merged for v4.6-rc1, so this hasn't been in a
> release, and should not break an existing user.
> 
> No compatible string is used here, which is precisely the confusion this
> addresses. The PSCI enable-method != the compatible string for a PSCI
> node, but the two got confused in a documentation patch, and then that
> confusion spread to code.
> 

Ok, thanks for the explanation.

	ARnd
