From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 1 Feb 2010 13:20:18 -0700 (MST)
Subject: [PATCH 6/9] omap3/4: Fix compile for multi-omap for
	clkops_noncore_dpll_ops
In-Reply-To: <20100130020136.10590.83332.stgit@baageli.muru.com>
References: <20100130020036.10590.78028.stgit@baageli.muru.com>
	<20100130020136.10590.83332.stgit@baageli.muru.com>
Message-ID: <alpine.DEB.2.00.1002011319340.20004@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jan 2010, Tony Lindgren wrote:

> Rename clkops_noncore_dpll_ops for omap3 and omap4.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Paul Walmsley <paul@pwsan.com>

In the long term we might try to share those, but this is an elegant 
solution for the purpose.

- Paul
