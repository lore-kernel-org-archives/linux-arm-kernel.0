From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 4 Jul 2013 17:34:24 +0100
Subject: [PATCH v3] ARM: LPAE: don't reject mapping /dev/mem above 4GB
In-Reply-To: <1372952185-2553-1-git-send-email-dserrg@gmail.com>
References: <1372952185-2553-1-git-send-email-dserrg@gmail.com>
Message-ID: <20130704163424.GA20048@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 04, 2013 at 04:36:25PM +0100, Sergey Dyasly wrote:
> With LPAE enabled, physical address space is larger than 4GB. Allow mapping any
> part of it via /dev/mem by using PHYS_MASK to determine valid range.
> 
> PHYS_MASK covers 40 bits with LPAE enabled and 32 bits otherwise.
> 
> Reported-by: Vassili Karpov <av1474@comtv.ru>
> Signed-off-by: Sergey Dyasly <dserrg@gmail.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
