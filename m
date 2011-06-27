From: khilman@ti.com (Kevin Hilman)
Date: Mon, 27 Jun 2011 15:12:06 -0700
Subject: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is...
	from driver
In-Reply-To: <87k4cm1xgj.fsf@ti.com>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org>  <87k4cm1xgj.fsf@ti.com>
Message-ID: <1309212726.6231.14.camel@vence>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-06-15 at 16:33 -0700, Kevin Hilman wrote:
> Hi Ben,
> 
> Ben Dooks <ben-i2c@fluff.org> writes:
> 
> > On Wed, Jun 01, 2011 at 05:19:26PM -0700, Kevin Hilman wrote:
> >> Ben, 
> >> 
> >> Please pull in this series from Andy Green for the next merge window.
> >> 
> >> v4 is simply a rebase of Andy's v3 against v3.0-rc1 with some basic
> >> sanity testing against with the latest kernel.
> >
> > These look much more like functionality changes than actual fixes, and
> > are much more suited for inclusion into -next for once the next stable
> > release is out.
> 
> Correct, this is a rework of functionality, not a set of fixes.  This
> series is targeted for the next release (v3.1), not for fixes
> (v3.0-rc).  
> 
> I was requesting for it to be included in your queue for -next and for
> the next merge window.
> 
> Tony has already been merging this in his omap-testing branch so it is
> has been getting lots of testing on OMAP platforms already.

Ping.  I don't see this in linux-next yet.

Are you planning to queue this for v3.1?

Thanks,

Kevin
