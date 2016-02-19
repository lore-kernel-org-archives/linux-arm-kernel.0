From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Feb 2016 14:30:31 +0000
Subject: [PATCH v4.1] arm64: perf: Count EL2 events if the kernel is
 running in HYP
In-Reply-To: <1455731859-26690-1-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-22-git-send-email-marc.zyngier@arm.com>
 <1455731859-26690-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160219143031.GI27062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 05:57:39PM +0000, Marc Zyngier wrote:
> When the kernel is running in HYP (with VHE), it is necessary to
> include EL2 events if the user requests counting kernel or
> hypervisor events.
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/kernel/perf_event.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
