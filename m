From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 29 Nov 2012 16:56:43 +0000
Subject: [PATCH] ARM64: Remove incorrect Kconfig symbol HAVE_SPARSE_IRQ
In-Reply-To: <1353856215-5371-1-git-send-email-shc_work@mail.ru>
References: <1353856215-5371-1-git-send-email-shc_work@mail.ru>
Message-ID: <20121129165643.GG30437@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 25, 2012 at 03:10:15PM +0000, Alexander Shiyan wrote:
> Kernel does not contain symbol HAVE_SPARSE_IRQ. Definition
> in arch/arm64/Kconfig seems typo because valid symbol is
> MAY_HAVE_SPARSE_IRQ.
> In any case SPARSE_IRQ is selected by default and we just
> remove selecting of this symbol.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Thanks. Applied.

-- 
Catalin
