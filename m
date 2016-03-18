From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 18 Mar 2016 15:30:59 +0100
Subject: [PATCH] ARM: configs: Enabling the new Marvell's cryptographic
 engine driver for mvebu_v7_defconfig
In-Reply-To: <20160318145131.76ffa0e1@free-electrons.com>
References: <20160318081209.GA7394@archy.home> <20160318131432.GB8005@lunn.ch>
 <20160318145131.76ffa0e1@free-electrons.com>
Message-ID: <20160318143059.GD8005@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 02:51:31PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> On Fri, 18 Mar 2016 14:14:32 +0100, Andrew Lunn wrote:
> 
> > Isn't this also applicable to mvebu v5?
> > 
> > And your change to multi_v7_defconfig could also be applied to
> > multi_v5_defconfig.
> 
> mvebu_v5 already enables a crypto driver, but it's the old one. So
> there's a decision to be taken here whether we move all the platforms
> to use the new driver or not.
> 
> The new driver has been tested on the Armada family, and I believe also
> on Kirkwood. However I'm pretty sure it hasn't been tested on Dove and
> Orion.

I don't know crypto to well. Is there a good test case? Something
simple to setup and run. I can test on kirkwood and Dove using the
hardware i have.

	 Andrew
