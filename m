From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Thu, 19 Jan 2017 10:13:38 +0800
Subject: [PATCH v10 0/8] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <588020D2.4020108@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On 2016/12/1 15:09, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> This patchset adds API for saving and restoring
> of VGICv3 registers to support live migration with new vgic feature.
> This API definition is as per version of VGICv3 specification
> Documentation/virtual/kvm/devices/arm-vgic-v3.txt
> 
> The patch 3 & 4 are picked from the Pavel's previous implementation.
> http://www.spinics.net/lists/kvm/msg122040.html
> 
> NOTE: Only compilation tested for AArch32. No hardware to test.
> 
Where can I fetch the latest corresponding QEMU patches? I didn't find
them in qemu-devel/qemu-arm mail list.

Thanks,
-- 
Shannon
