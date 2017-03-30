From: will.deacon@arm.com (Will Deacon)
Date: Thu, 30 Mar 2017 19:15:25 +0100
Subject: [PATCH] arm64: remove redundant header file in current.h
In-Reply-To: <1490877709-221439-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1490877709-221439-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <20170330181524.GE14608@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 08:41:49PM +0800, Shaokun Zhang wrote:
> Commint 9d84fb27fa1 ("arm64: restore get_current() optimisation") has 
> removed read_sysreg() and asm/sysreg.h is redundant.
> 
> This patch removes asm/sysreg.h header file.
> 
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
> ---
>  arch/arm64/include/asm/current.h | 2 --
>  1 file changed, 2 deletions(-)

This is trivial, so I'll pick it up. Thanks.

Will
