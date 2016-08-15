From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Aug 2016 10:46:50 +0100
Subject: [PATCH] arm: remove traces of perf_ops_bp
In-Reply-To: <1470934766-4009-1-git-send-email-mark.rutland@arm.com>
References: <1470934766-4009-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160815094649.GA13262@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 05:59:26PM +0100, Mark Rutland wrote:
> Even though perf_ops_bp was removed/renamed back in commit
> b0a873ebbf87bf38 ("perf: Register PMU implementations"), as part of
> v2.6.37, its definition still lives on in some arch headers.
> 
> This patch removes the vestigal definition from arm.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  arch/arm/include/asm/hw_breakpoint.h | 1 -
>  1 file changed, 1 deletion(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Please put this into the patch system -- I'll pick the other one up for
arm64.

Will
