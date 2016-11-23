From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 23 Nov 2016 17:37:05 +0530
Subject: [PATCH v2 1/3] ARM: davinci: da8xx: Fix ohci device name
In-Reply-To: <20161103160308.29588-2-ahaslam@baylibre.com>
References: <20161103160308.29588-1-ahaslam@baylibre.com>
 <20161103160308.29588-2-ahaslam@baylibre.com>
Message-ID: <50af5764-051a-63c1-e2c4-7b2799f9d3ae@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 03 November 2016 09:33 PM, Axel Haslam wrote:
> While the clk lookup table is making reference to "ohci"
> other subsystems (such as phy) are trying to match "ohci.0"
> 
> Since there is a single ohci instance, instead of changing
> the clk name, change the dev id to -1, and add the "-da8xx"
> postfix to match the driver name that will also be changed
> in a subsequent patch.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied to v4.10/soc

Thanks,
Sekhar
