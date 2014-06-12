From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Jun 2014 15:48:47 +0100
Subject: [PATCH] arm64/crypto: fix and improve GHASH secure hash
 implementation
In-Reply-To: <1402584187-17114-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1402584187-17114-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140612144847.GC8970@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 12, 2014 at 03:43:07PM +0100, Ard Biesheuvel wrote:
> This fixes a bug in the arm64 GHASH implementation, and switches to a faster,
> polynomial multiplication based reduction instead of one that uses
> shifts and rotates.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> This is a bug fix and a performance optimization in a single patch.

Thanks. I'll push it after -rc1.

> As the code has never worked correctly and was merged just a couple of
> days ago,

IIRC you said you tested the crypto patches.

-- 
Catalin
