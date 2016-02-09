From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 17:24:54 +0000
Subject: [PATCH 0/4] arm64: cpufeature: Fix sign of feature bits
In-Reply-To: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
References: <1453805896-4397-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160209172453.GW22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 10:58:12AM +0000, Suzuki K Poulose wrote:
> ARM ARM is getting updated with the guidelines on how to treat the
> feature values for their sign. This series fixes the handling of sign
> based on the new update. Also make the capabilities aware of the sign
> of the feature to use the appropriate helper for extracting the values.

For the series:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
