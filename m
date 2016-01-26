From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 26 Jan 2016 11:24:26 +0000
Subject: [PATCH 0/4] arm64: cpufeature: Fix sign of feature bits
In-Reply-To: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <56A7576A.5050304@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/01/16 10:58, Suzuki K Poulose wrote:
> ARM ARM is getting updated with the guidelines on how to treat the
> feature values for their sign. This series fixes the handling of sign
> based on the new update. Also make the capabilities aware of the sign
> of the feature to use the appropriate helper for extracting the values.
>
> See Patch2 for more details on the rules.

This series applies on top of the "Early CPU feature verification"  :

  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/401727.html

I can send a version based on 4.5-rc1 if this can be picked up for 4.5

Thanks
Suzuki
