From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 1 Jun 2018 15:14:10 +0100
Subject: [PATCHv2 0/4] arm64: SMCCC conduit cleanup
In-Reply-To: <20180531173223.9668-1-mark.rutland@arm.com>
References: <20180531173223.9668-1-mark.rutland@arm.com>
Message-ID: <20180601141410.e7dwvmqiqi2esbnk@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2018 at 06:32:19PM +0100, Mark Rutland wrote:
> Mark Rutland (4):
>   arm/arm64: smccc/psci: add arm_smccc_1_1_get_conduit()
>   arm64: errata: use arm_smccc_get_conduit()
>   firmware/psci: use common SMCCC_CONDUIT_*
>   firmware: arm_sdei: use common SMCCC_CONDUIT_*

Queued for 4.18. Thanks.

-- 
Catalin
