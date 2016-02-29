From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Feb 2016 17:19:17 +0000
Subject: [PATCH] arm64: mm: list kernel sections in order
In-Reply-To: <1456525992-17297-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1456525992-17297-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160229171917.GE7935@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 11:33:12PM +0100, Ard Biesheuvel wrote:
> In the boot log, instead of listing .init first, list .text, .rodata,
> .init and .data in the same order they appear in memory
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
