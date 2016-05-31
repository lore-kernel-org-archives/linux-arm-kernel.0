From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 31 May 2016 17:53:11 +0100
Subject: [PATCH 0/3] arm64: Kill ESR_LNX_EXEC
In-Reply-To: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
References: <1464694383-31700-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20160531165311.GD11321@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2016 at 12:33:00PM +0100, Mark Rutland wrote:
> Mark Rutland (3):
>   arm64: add macro to extract ESR_ELx.EC
>   arm64/kvm: use ESR_ELx_EC to extract EC
>   arm64: kill ESR_LNX_EXEC

For the series:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
