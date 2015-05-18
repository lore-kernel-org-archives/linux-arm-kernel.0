From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:21:09 +0100
Subject: [PATCHv2 03/12] arm64: smp: consistently use error codes
In-Reply-To: <1431945503-6939-4-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-4-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518172109.GJ21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:14AM +0100, Mark Rutland wrote:
> cpu_kill currently returns one for success and zero for failure, which
> is unlike all the other cpu_operations, which return zero for success
> and an error code upon failure. This difference is unnecessarily
> confusing.
> 
> Make cpu_kill consistent with the other cpu_operations.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
