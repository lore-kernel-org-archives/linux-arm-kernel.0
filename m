From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 19 Nov 2012 12:07:49 -0700
Subject: [PATCH] mfd: vexpress-sysreg: Remove LEDs code
In-Reply-To: <1353332344-16754-1-git-send-email-pawel.moll@arm.com>
References: <1353332344-16754-1-git-send-email-pawel.moll@arm.com>
Message-ID: <50AA8385.7020007@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/2012 06:39 AM, Pawel Moll wrote:
> As the current LEDs code breaks other platform, remove it.
> 
> It shall be replaced by a generic "MMIO LEDs" driver.
> 
> Reported-by: Stephen Warren <swarren@wwwdotorg.org>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>

Tested-by: Stephen Warren <swarren@nvidia.com>
