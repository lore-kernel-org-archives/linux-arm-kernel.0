From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 19 Apr 2012 14:21:29 +0000
Subject: [PATCH v2 0/8] Second patchset for LPC32xx device tree conversion
In-Reply-To: <20120418165650.GD3099@opensource.wolfsonmicro.com>
References: <1334682507-15055-1-git-send-email-stigge@antcom.de>
 <201204181100.40123.arnd@arndb.de>
 <20120418165650.GD3099@opensource.wolfsonmicro.com>
Message-ID: <201204191421.29558.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 April 2012, Mark Brown wrote:
> On Wed, Apr 18, 2012 at 11:00:39AM +0000, Arnd Bergmann wrote:
> 
> > 1. develop on -rc
> > 2. merge with latest -next, test and make sure it works there
> > 3. submit for review against -rc
> > 4. have patches included in -next once reviewed, but based on -rc
> > 5. when merge window opens, have patches sent for upstream inclusion
> 
> Steps 3 and 4 should be to submit against whatever branch is appropriate
> for the subsystem and driver - if people follow this process they're
> going to get bounced back by a fair proportion of maintainers, -rc isn't
> universally what people are looking for so people should be aware that
> they need to pay attention here.  
> 
> Generally I'd say the development version is a safer bet than -rc for
> most subsystems.

Right. The description above was mostly done for the lpc32xx case,
which is going to get merged through the arm-soc tree and that doesn't
have a single development branch but instead has lots of them.

For subsystems that have just one branch, I agree that it makes sense
to develop against that one. Also for arm-soc, it can make sense
to base on one of the existing branches, but I prefer the default
to be to base on the -rc release so I can mix and match incoming
branches as needed.

	Arnd
