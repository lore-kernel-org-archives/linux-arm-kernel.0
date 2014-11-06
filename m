From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 5 Nov 2014 18:23:08 -0600
Subject: [V10 PATCH 2/2] irqchip: gicv2m: Add supports for ARM GICv2m
 MSI(-X)
In-Reply-To: <545ABB4C.8010103@amd.com>
References: <1415052977-26036-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1415052977-26036-3-git-send-email-suravee.suthikulpanit@amd.com>
 <5458CE31.3040404@linux.intel.com> <545ABB4C.8010103@amd.com>
Message-ID: <545ABF6C.1000308@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/5/2014 6:05 PM, Suravee Suthikulanit wrote:
> - Overall, it seems that msi_domain_alloc() could be quite different
> across architectures. Would it be possible to declare this function as
> weak, and allow arch to override (similar to arch_setup_msi_irq)?

Actually, declaring "msi_domain_ops" as non-static, and allow other code 
to override the .alloc and .free?

Thanks,

Suravee
