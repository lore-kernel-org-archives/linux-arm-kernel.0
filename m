From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 29 May 2015 11:06:25 +0100
Subject: [PATCH 1/7] arm-cci: Do not enable CCI-400 PMU by default
In-Reply-To: <1432633996-7229-2-git-send-email-suzuki.poulose@arm.com>
References: <1432633996-7229-1-git-send-email-suzuki.poulose@arm.com>
 <1432633996-7229-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <55683A21.9000105@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/15 10:53, Suzuki K. Poulose wrote:
> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>
> Do not enable CCI-400 PMU by default and fix the dependency on PERF_EVENTS
> than HW_PERF_EVENTS.
>
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: arm at kernel.org
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Forgot to add :

Acked-by: Punit Agrawal <punit.agrawal@arm.com>

from https://patchwork.kernel.org/patch/6387121/

Thanks
Suzuki
