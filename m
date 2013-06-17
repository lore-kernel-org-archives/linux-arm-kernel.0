From: tj@kernel.org (Tejun Heo)
Date: Mon, 17 Jun 2013 11:24:46 -0700
Subject: [PATCH V2] ahci: sata: add support for exynos5440 sata
In-Reply-To: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
References: <1366104482-14240-1-git-send-email-ks.giri@samsung.com>
Message-ID: <20130617182446.GI32663@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 16, 2013 at 02:58:02PM +0530, Girish K S wrote:
> This patch adds the compatible string of the exynos5440 sata controller
> compliant with the ahci 1.3 and sata 3.0 specification.
> 
> Signed-off-by: Girish K S <ks.giri@samsung.com>
> 
> changes in v2:
> 		changed the compatible string by adding the actual IP
> owners name instead of the SoC vendor name.

Applied to libata/for-3.11.

Can you please keep SOB at the end of the description after the
revision history from the next time?

Thanks.

-- 
tejun
