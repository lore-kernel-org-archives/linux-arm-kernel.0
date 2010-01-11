From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Mon, 11 Jan 2010 16:38:12 +1100
Subject: [RFC,PATCH 1/7] arm: add a common struct clk
In-Reply-To: <201001081238.31842.jeremy.kerr@canonical.com>
References: <1262907852.736281.78480196040.1.gpush@pororo>
	<1262913477.2173.696.camel@pasglop>
	<201001081238.31842.jeremy.kerr@canonical.com>
Message-ID: <201001111638.12204.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben,
 
> Good point, will inline these.

.. and now I remember why I didn't: linux/clk.h defines these as non-static.

Alternative is to move the COMMON_STRUCT_CLK API to general kernel land, and 
put the definitions in the global clk.h.

Cheers,


Jeremy
