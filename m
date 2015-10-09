From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 9 Oct 2015 16:29:27 +0100
Subject: [PATCH 1/2] dmaengine: hdmac: factorise memset descriptor
 allocation
In-Reply-To: <20151007173317.GG2278@lukather>
References: <1443711158-18495-1-git-send-email-maxime.ripard@free-electrons.com>
 <1443711158-18495-2-git-send-email-maxime.ripard@free-electrons.com>
 <20151007135412.GB3320@vkoul-mobl.iind.intel.com>
 <20151007173317.GG2278@lukather>
Message-ID: <20151009152926.GD3609@vkoul-mobl.iind.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 06:33:17PM +0100, Maxime Ripard wrote:
> > This is fine, but this is driver limitation. We should really split the
> > txn to multiple descriptors here..
> 
> Both these things are actually just copy from the previous code.
> 
> I can probably fix the first style issue in this patch, but splitting
> the memset descriptors should go in a separate patch.

That sounds fine

-- 
~Vinod
