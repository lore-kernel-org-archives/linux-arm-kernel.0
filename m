From: horms@verge.net.au (Simon Horman)
Date: Mon, 17 Mar 2014 15:52:58 +0900
Subject: [GIT PULL] Renesas intc Updates for v3.15
In-Reply-To: <20140317062907.GA21917@quad.lixom.net>
References: <cover.1392962498.git.horms+renesas@verge.net.au>
 <20140317062907.GA21917@quad.lixom.net>
Message-ID: <20140317065258.GH9297@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 16, 2014 at 11:29:07PM -0700, Olof Johansson wrote:
> On Fri, Feb 21, 2014 at 03:11:58PM +0900, Simon Horman wrote:
> > Hi Olof, Hi Kevin, Hi Arnd,
> > 
> > Please consider this Renesas ARM based SoC intc updates for v3.15.
> > 
> > Previously merging code for this driver was handled Paul Mundt
> > as part of his maintenance of SUPERH. However, SUPERH is in
> > the process of being orphaned. And as this driver is also listed
> > as being maintained by Magnus and myself as part of ARM/SHMOBILE ARM
> > I have picked up this patch.
> > 
> > If you would prefer not to handle this that is quite fine by me but in that
> > case I would appreciate advice on where I should send pull-requests.
> 
> Do you anticipate any new development besides some minor one-off fixes and
> touching code that's related to shmobile/sh reworks?
> 
> If it's a low-volume thing that is likely to mostly have overlap with
> arm-soc/shmobile stuff then we might just as well take most of it. Otherwise,
> I think most architecture maintainers send things directly to Linus.
> 
> Either way, I'll merge this for now.

Hi Olof,

at this stage I am not expecting major developments of drivers under
drivers/sh. But I do expect minor fixes, improvements, Kconfig updates,
etc...

I am more than happy to start sending things to Linus.
But perhaps this time it would be easiest for you to take this one.
