From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Feb 2016 14:30:45 +0000
Subject: [PATCH v4.1] arm64: hw_breakpoint: Allow EL2 breakpoints if
 running in HYP
In-Reply-To: <1455731923-26768-1-git-send-email-marc.zyngier@arm.com>
References: <1455216004-19499-23-git-send-email-marc.zyngier@arm.com>
 <1455731923-26768-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160219143045.GJ27062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 05:58:43PM +0000, Marc Zyngier wrote:
> With VHE, we place kernel {watch,break}-points at EL2 to get things
> like kgdb and "perf -e mem:..." working.
> 
> This requires a bit of repainting in the low-level encore/decode,
> but is otherwise pretty simple.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm64/include/asm/hw_breakpoint.h | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
