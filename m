From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Mon, 19 Oct 2015 14:09:44 +0100
Subject: [PATCHv4 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
References: <1445259647-21541-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <5624EB98.5030407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/10/15 14:00, Suzuki K. Poulose wrote:
> This series introduces a new infrastructure to keep track of the CPU
> feature registers on ARMv8-A for arm64 kernel. It provides the safe value
> of a CPU feature register across all the CPUs on (a heterogeneous) system.
> The infrastructure checks the individual CPU feature registers as they are

PS: There was a mistake in Christoffer's email id (again!, I think I should
take a break).

Thanks
Suzuki
