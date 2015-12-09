From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 Dec 2015 10:25:59 +0000
Subject: [PATCH v5 4/5] gicv2m: Refactor to prepare for ACPI support
In-Reply-To: <1449625686-5594-5-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1449625686-5594-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <1449625686-5594-5-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <20151209102559.1110916f@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Dec 2015 17:48:05 -0800
Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com> wrote:

> This patch replaces the struct device_node with struct fwnode_handle
> since this structure is common between DT and ACPI.
> 
> It also refactors gicv2m_init_one() to prepare for ACPI support.
> There should be no functional changes.
> 
> Signed-off-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
