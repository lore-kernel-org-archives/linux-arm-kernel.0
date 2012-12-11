From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Dec 2012 12:02:08 -0700
Subject: [PATCH V3] ARM: bcm281xx: Add timer driver
In-Reply-To: <1355250387-622-1-git-send-email-csd@broadcom.com>
References: <1355250387-622-1-git-send-email-csd@broadcom.com>
Message-ID: <50C78330.7040605@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2012 11:26 AM, Christian Daudt wrote:
> This adds support for the Broadcom timer, used in the following SoCs:
> BCM11130, BCM11140, BCM11351, BCM28145, BCM28155

Reviewed-by: Stephen Warren <swarren@nvidia.com>

> This patch needs the arm-soc/soc/next branch

Only if it goes into 3.8, which I assume it won't?

For 3.9, you'll need to rebase it on top of my struct sys_timer removal
series, which I hope to put into linux-next ASAP after 3.8-rc1 comes out.
