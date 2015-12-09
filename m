From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 Dec 2015 10:20:13 +0000
Subject: [PATCH v5 2/5] irqdomain: introduce is_fwnode_irqchip helper
In-Reply-To: <1449625686-5594-3-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449625686-5594-3-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <20151209102013.6193b3ac@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Dec 2015 17:48:03 -0800
Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:

> Since there will be several places checking if fwnode.type
> is equal FWNODE_IRQCHIP, this patch adds a convenient function
> for this purpose.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
