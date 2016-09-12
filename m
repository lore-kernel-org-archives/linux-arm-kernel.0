From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 12 Sep 2016 14:15:47 +0100
Subject: [PATCH v4 0/5] arm/arm64: vgic-new: Implement API for vGICv3 live
 migration
In-Reply-To: <1473510138-4719-1-git-send-email-vijay.kilari@gmail.com>
References: <1473510138-4719-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <57D6AA83.6060208@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/09/16 13:22, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> This patchset adds API for saving and restoring
> of VGICv3 registers to support live migration with new vgic feature.
> This API definition is as per version of VGICv3 specification
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
> 
> Compatible live migration QEMU patches will be sent later.

Could you please point to the QEMU patches as well? I need to be able to
test the this infrastructure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
