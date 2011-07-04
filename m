From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 04 Jul 2011 18:35:05 +0900
Subject: [PATCH V2 3/8] ARM: EXYNOS4: Add support PM with external GIC
In-Reply-To: <20110701212144.GF21898@n2100.arm.linux.org.uk>
References: <1309485457-13305-1-git-send-email-kgene.kim@samsung.com>
	<1309485457-13305-4-git-send-email-kgene.kim@samsung.com>
	<20110701212144.GF21898@n2100.arm.linux.org.uk>
Message-ID: <004e01cc3a2d$abab2080$03016180$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 
> Why not fix arch/arm/common/gic.c to save and restore the GIC state
> itself?
> 
Sorry I missed that. I saw "ARM: gic: Use cpu pm notifiers to save gic
state" by Colin Cross just now so will follow that up for supporting Samsung
SoCs which use GIC.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
