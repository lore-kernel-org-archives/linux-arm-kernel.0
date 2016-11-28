From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 28 Nov 2016 20:51:36 +0100
Subject: [PATCH v9 0/11] arm/arm64: vgic: Implement API for vGICv3 live
 migration
In-Reply-To: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
References: <1479906118-15832-1-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20161128195136.GI18170@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vijaya,

On Wed, Nov 23, 2016 at 06:31:47PM +0530, vijay.kilari at gmail.com wrote:
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

I did not review the 32-bit part, because if you cannot test it, I don't
think we should merge it.

I just want clarity on what happens if someone tries to use this on
32-bit, and I want to make sure it fails gracefully.

Thanks,
-Christoffer
