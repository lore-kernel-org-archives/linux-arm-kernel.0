From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 11 Jan 2010 10:46:21 +0000
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001111638.12204.jeremy.kerr@canonical.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262913477.2173.696.camel@pasglop>
	<201001081238.31842.jeremy.kerr@canonical.com>
	<201001111638.12204.jeremy.kerr@canonical.com>
Message-ID: <20100111104621.GC3440@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 11, 2010 at 04:38:12PM +1100, Jeremy Kerr wrote:

> Alternative is to move the COMMON_STRUCT_CLK API to general kernel land, and 
> put the definitions in the global clk.h.

Wouldn't that be sensible anyway?  There's nothing ARM specific about
any of this except that you've used it in some ARM platforms.
