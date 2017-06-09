From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Fri, 9 Jun 2017 18:22:16 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170609150340.GH20756@lunn.ch>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
 <a60a0b26-62b1-7c9e-e846-215747dddb1f@gmail.com>
 <20170609082541.GC31464@kwain> <20170609132624.GC20756@lunn.ch>
 <20170609140922.GD31464@kwain> <20170609144936.GF20756@lunn.ch>
 <20170609145630.GE31464@kwain> <20170609150340.GH20756@lunn.ch>
Message-ID: <20170609162216.GF31464@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 05:03:40PM +0200, Andrew Lunn wrote:
> > There are two busses, one generating c22 transactions and one generating
> > c45 transactions. Each bus has its own MDC/MDIO pins.
> 
> O.K. That is what i wanted to know. So we want two completely separate
> device tree bindings, busses registered with Linux, etc.
> 
> Thanks for clarification.

So in the end I need one change in v3: to bind the xSMI usage to
marvell,xmdio and the SMI one to marvell,orion-mdio. (Plus the GENMASK
and offset comments).

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/312316eb/attachment.sig>
