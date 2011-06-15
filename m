From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 15 Jun 2011 19:27:31 -0400 (EDT)
Subject: [PATCH v4 00/18] I2C: OMAP: I2C fixes, removal of cpu_is... from
	driver
In-Reply-To: <20110615213637.GH15795@trinity.fluff.org>
References: <1306973984-15165-1-git-send-email-khilman@ti.com>
	<20110615213637.GH15795@trinity.fluff.org>
Message-ID: <alpine.LFD.2.00.1106151919070.2142@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun 2011, Ben Dooks wrote:

> On Wed, Jun 01, 2011 at 05:19:26PM -0700, Kevin Hilman wrote:
> > Ben, 
> > 
> > Please pull in this series from Andy Green for the next merge window.
> > 
> > v4 is simply a rebase of Andy's v3 against v3.0-rc1 with some basic
> > sanity testing against with the latest kernel.
> 
> These look much more like functionality changes than actual fixes, and
> are much more suited for inclusion into -next for once the next stable
> release is out.

What do you mean, exactly?  The merge window, as opposed to 
the -rc period, is good for functionality changes, no?

Those patches have been out for quite a while, and they got quite 
extensive testing in the OMAP tree, and in the kernel included with the 
Linaro 11.05 release as well.


Nicolas
