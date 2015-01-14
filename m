From: wuyun.wu@huawei.com (Yun Wu (Abel))
Date: Wed, 14 Jan 2015 16:17:13 +0800
Subject: [PATCH v2 3/8] PCI/MSI: of: Add support for OF-provided msi_domain
In-Reply-To: <1420736772-11088-4-git-send-email-marc.zyngier@arm.com>
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
 <1420736772-11088-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <54B62609.7020002@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/9 1:06, Marc Zyngier wrote:

> In order to populate the PHB msi_domain, use the "msi-parent"
> attribute to lookup a corresponding irq domain. If found,
> this is our MSI domain.
> 
> This gets plugged into the core PCI code.
> 

Hi Marc,

Since the whole patch series based on the fact that non PCI type
buses will use MSI-like interrupts, would it be better if getting
this field settled during OF populating?

Regards,
	Abel
