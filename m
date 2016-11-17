From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 17 Nov 2016 12:41:16 +0100
Subject: [PATCH v8 0/7] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <1478258013-6669-1-git-send-email-vijay.kilari@gmail.com>
References: <1478258013-6669-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20161117114116.GB22231@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On Fri, Nov 04, 2016 at 04:43:26PM +0530, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>
> 
> This patchset adds API for saving and restoring
> of VGICv3 registers to support live migration with new vgic feature.
> This API definition is as per version of VGICv3 specification
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-July/445611.html
> 
> The patch 3 & 4 are picked from the Pavel's previous implementation.
> http://www.spinics.net/lists/kvm/msg122040.html
> 
> v7 => v8:
>  - Rebased to 4.9-rc3

I noticed when looking at this series that there are quite a few
conflicts when applying to kvmarm/queue, so if you could rebase the next
verson on kvmarm/queue, then you'll make Marc's life a bit easier.

Thanks,
-Christoffer
