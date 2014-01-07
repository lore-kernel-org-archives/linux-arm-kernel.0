From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Jan 2014 17:23:38 +0000
Subject: [PATCH v2 3/5] arm: add early_ioremap support
In-Reply-To: <1389062120-31896-4-git-send-email-msalter@redhat.com>
References: <1389062120-31896-1-git-send-email-msalter@redhat.com>
 <1389062120-31896-4-git-send-email-msalter@redhat.com>
Message-ID: <20140107172338.GB6234@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 02:35:18AM +0000, Mark Salter wrote:
> This patch uses the generic early_ioremap code to implement
> early_ioremap for ARM. The ARM-specific bits come mostly from
> an earlier patch from Leif Lindholm <leif.lindholm@linaro.org>
> here:
> 
>   https://lkml.org/lkml/2013/10/3/279
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Tested-by: Leif Lindholm <leif.lindholm@linaro.org>
> CC: linux-arm-kernel at lists.infradead.org
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Arnd Bergmann <arnd@arndb.de>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
