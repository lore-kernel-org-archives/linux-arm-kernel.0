From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Feb 2016 15:37:32 +0000
Subject: [PATCH] arm64: Add support for Half precision floating point
In-Reply-To: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
References: <1453823566-26742-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160226153732.GO4777@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:52:46PM +0000, Suzuki K. Poulose wrote:
> ARMv8.2 extensions [1] include an optional feature, which supports
> half precision(16bit) floating point/asimd data processing
> instructions. This patch adds support for detecting and exposing
> the same to the userspace via HWCAPs
> 
> [1] https://community.arm.com/groups/processors/blog/2016/01/05/armv8-a-architecture-evolution
> 
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>

Applied. Thanks.

-- 
Catalin
