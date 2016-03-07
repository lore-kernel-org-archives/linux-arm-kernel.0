From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 7 Mar 2016 20:20:37 +0530
Subject: [TRIVIAL PATCH] treewide: Remove unnecessary 0x prefixes before
 %pa extension uses
In-Reply-To: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
References: <dcdebc08a17023fac93595312281cb8e91185668.1457162650.git.joe@perches.com>
Message-ID: <20160307145037.GF11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 11:46:32PM -0800, Joe Perches wrote:
> Since commit 3cab1e711297 ("lib/vsprintf: refactor duplicate code
> to special_hex_number()") %pa uses have been ouput with a 0x prefix.
> 
> These 0x prefixes in the formats are unnecessary.
> 

For this:
>  drivers/dma/at_hdmac_regs.h              | 2 +-

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
