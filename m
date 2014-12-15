From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 15 Dec 2014 11:07:52 -0500
Subject: [PATCH 00/27] ARM: mvebu: armada-*: Relicense the device tree
 under GPLv2+/X11
In-Reply-To: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
References: <1418657915-22775-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141215160752.GE967@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

Good to see this finally being addressed.  One not-so-minor issue below.

On Mon, Dec 15, 2014 at 04:38:08PM +0100, Gregory CLEMENT wrote:
> Hello,
> 
> You've been Cc'd on a relicensing patch, because at some point you
> contributed a patch to an mvebu device tree.
> 
> We're currently moving toward a GPL/X11 dual-license, instead of a GPL
> license like what was done when you submitted your patches.

I like the X11 license, much more liberal than the BSD I had been
thinking of.

What were the reasons for changing GPLv2 -> GPLv2+?  Why not preserve
the author's intent re GPL and do:

	GPLv2  -> GPLv2/X11
	GPLv2+ -> GPLv2+/X11

Please note: I have no interest is a flame war re GPLv2/GPLv3.  No ones
minds are going to be changed at this point.  I'm simply looking to stay
closer to the author's intentions and extend the usefulness of the DT
tree.

thx,

Jason.
