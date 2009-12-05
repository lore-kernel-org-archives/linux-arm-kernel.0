From: mpm@selenic.com (Matt Mackall)
Date: Sat, 5 Dec 2009 12:56:46 -0600
Subject: [PATCH V2 1/2] arm nomadik: add hardware RNG driver
In-Reply-To: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
References: <376a2243795aadfb87c8a7f5ea039.1260011962.git.rubini@unipv.it>
Message-ID: <20091205185646.GQ8789@waste.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 05, 2009 at 12:31:28PM +0100, Alessandro Rubini wrote:
> From: Alessandro Rubini <rubini@unipv.it>
> 
> The hardware random number generator by ST is used in both the Nomadik
> 8815 SoC and the U8500. It returns 16 bits every 400ns with automatic
> delay if a read is issued too early. It depends on PLAT_NOMADIK.
> 
> Signed-off-by: Alessandro Rubini <rubini@unipv.it>
> Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>

Looks good to me.

Acked-by: Matt Mackall <mpm@selenic.com>

-- 
Mathematics is the supreme nostalgia of our time.
