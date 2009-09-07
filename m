From: ben-linux@fluff.org (Ben Dooks)
Date: Mon, 7 Sep 2009 14:24:37 +0100
Subject: [PATCH 0/4] s3c6410: Samsung 6410 clock configuration fixes.
In-Reply-To: <1252326311-5647-1-git-send-email-thomas.ab@samsung.com>
References: <1252326311-5647-1-git-send-email-thomas.ab@samsung.com>
Message-ID: <20090907132437.GF2367@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 07, 2009 at 09:25:11PM +0900, Thomas Abraham wrote:
> This patch series fixes issues in the Samsung's 6410 clock configuration
> code. These patches are required for the correct functioning of the 
> s3c6410 SDHCI driver. The following patches are included in this 
> patch series.
> 
> [PATCH 1/4] s3c6410: use correct divider_shift in setrate_clksrc()
> [PATCH 2/4] s3c6410: update clk->parent when setting clock source
> [PATCH 3/4] s3c6410: Fix divider value calculation in s3c64xx_roundrate_clksrc
> [PATCH 4/4] s3c6410: Remove redundant mpll parent assignment.

A brief review seems to indicate they are ok, it is just whether this
late in the release cycle it is worth trying to push them as fixes or
adding them to the -next tree for 2.6.31 inclusion.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
