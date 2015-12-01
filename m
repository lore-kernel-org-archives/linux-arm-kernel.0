From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 1 Dec 2015 16:30:35 +0000
Subject: [PATCH] arm64: update linker script to increased L1_CACHE_BYTES
 value
In-Reply-To: <1448972440-32633-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1448972440-32633-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151201163034.GA10747@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 01, 2015 at 01:20:40PM +0100, Ard Biesheuvel wrote:
> Bring the linker script in line with the recent increase of
> L1_CACHE_BYTES to 128. Replace the hardcoded value of 64 with the
> symbolic constant.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
