From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 3 Nov 2009 17:36:20 +0000
Subject: [PATCH 2/9] S3C64XX: Fix S3C64XX_CLKDIV0_ARM_MASK value
In-Reply-To: <1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1257259332-7867-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1257259332-7867-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20091103173619.GI23772@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2009 at 02:42:05PM +0000, Mark Brown wrote:
> From: Kukjin Kim <kgene.kim@samsung.com>
> 
> The value of S3C64XX_CLKDIV0_ARM_MASK is wrong. This patch fixes
> this values, S3C6400_CLKDIV0_ARM_MASK and S3C6410_CLKDIV0_ARM_MASK.

this should be merged now.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
