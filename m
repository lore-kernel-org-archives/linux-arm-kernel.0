From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 19 Nov 2010 10:58:07 -0800
Subject: [PATCH] ARM: Make the argument to virt_to_phys() "const volatile"
In-Reply-To: <20101118135026.10541.8683.stgit@e102109-lin.cambridge.arm.com>
References: <20101118135026.10541.8683.stgit@e102109-lin.cambridge.arm.com>
Message-ID: <4CE6C8BF.8040204@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2010 05:50 AM, Catalin Marinas wrote:
> Changing the virt_to_phys() argument to "const volatile void *" avoids
> compiler warnings in some situations where this function is used.
>
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

Thanks.
