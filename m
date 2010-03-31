From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 31 Mar 2010 09:59:49 +0100
Subject: [PATCH] ARM: SMDK6410: Register AC97 controller
In-Reply-To: <20100331010159.GI31126@trinity.fluff.org>
References: <1269517968-27945-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100331010159.GI31126@trinity.fluff.org>
Message-ID: <20100331085948.GA2504@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 02:01:59AM +0100, Ben Dooks wrote:
> On Thu, Mar 25, 2010 at 11:52:48AM +0000, Mark Brown wrote:

> > The SMDK6410 has a WM9713 connected to the AC97 interface, by default
> > on the GPD pins though this can be changed with a switch on the board.

> Hmm, I really don't like the fact that we've no good way of finding
> out what the switch positions are...

Not much we can do about the existing hardware, sadly.  There's a bunch
of other similar switches on the board (like the one that selects
between the two ethernet controllers) as well.
