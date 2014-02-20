From: balajitk@ti.com (Balaji T K)
Date: Thu, 20 Feb 2014 18:51:45 +0530
Subject: [PATCH V2 2/2] ARM: dts: omap3-ldp: fix mmc configuration
In-Reply-To: <1392356749-32091-3-git-send-email-nm@ti.com>
References: <1392356749-32091-1-git-send-email-nm@ti.com>
 <1392356749-32091-3-git-send-email-nm@ti.com>
Message-ID: <53060169.2050207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 14 February 2014 11:15 AM, Nishanth Menon wrote:
> MMC1 is the only MMC interface available on the platform. Further,
> since the platform is based on older revision of SoC which is not
> capable of doing multi-block reads, mark it with compatibility for the
> same and add pinmux to ensure that all relevant pins are configured
> for non-MMC boot mode.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

looks good to me
Acked-by: Balaji T K <balajitk@ti.com>
