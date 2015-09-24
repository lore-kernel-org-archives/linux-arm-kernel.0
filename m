From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 24 Sep 2015 14:33:19 +0300
Subject: [PATCH 1/3] arm/arm64: KVM: vgic: Check for !irqchip_in_kernel()
 when mapping resources
In-Reply-To: <1442419087-24648-2-git-send-email-marc.zyngier@arm.com>
References: <1442419087-24648-1-git-send-email-marc.zyngier@arm.com>
 <1442419087-24648-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <169201d0f6bc$d03df3f0$70b9dbd0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> Until b26e5fdac43c ("arm/arm64: KVM: introduce per-VM ops"),
> kvm_vgic_map_resources() used to include a check on irqchip_in_kernel(),
> and vgic_v2_map_resources() still has it.

 I'm back from vacation and very glad to see myself being useful :)
 What's with the rest of that patch set? Does it need rebase or what ?
 By the way, after this is applied, we can drop useless check inside vgic_v2_map_resources(). 

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
