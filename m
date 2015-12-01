From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 1 Dec 2015 15:15:23 +0000
Subject: [PATCH v2 0/6] arm64: cpufeature: Add sanity check for ASIDBits
In-Reply-To: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <565DB98B.9090504@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 15:12, Suzuki K. Poulose wrote:
> This series adds support for verifying some of the cpufeatures
> that are decided early in the boot process based on the boot
> CPU and cannot be delayed (e.g, ASIDBits and may be VHE?). It also
> adds one of the users of this early hook, check for ASIDBits.

Catalin,

This is based on 4.4-rc3 and adds the ASIDBits check, which was missed
in the cpufeature infrastructure series.

Thanks
Suzuki
