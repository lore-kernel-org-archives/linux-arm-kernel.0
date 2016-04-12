From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Apr 2016 14:10:36 +0100
Subject: [PATCH 5/6] ARM64: Remove arm_pm_restart
In-Reply-To: <1460120039-2497-6-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
 <1460120039-2497-6-git-send-email-linux@roeck-us.net>
Message-ID: <20160412131036.GB8066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 05:53:58AM -0700, Guenter Roeck wrote:
> All users of arm_pm_restart have been converted to use the kernel restart
> handler.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/arm64/include/asm/system_misc.h | 2 --
>  arch/arm64/kernel/process.c          | 7 +------
>  2 files changed, 1 insertion(+), 8 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
