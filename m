From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Jun 2014 10:46:02 +0100
Subject: [PATCH 1/2] arm64/crypto: fix data corruption bug in GHASH
 algorithm
In-Reply-To: <1402912936-9137-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1402912936-9137-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20140618094601.GD11973@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 16, 2014 at 11:02:15AM +0100, Ard Biesheuvel wrote:
> This fixes a bug in the GHASH algorithm resulting in the calculated hash to be
> incorrect if the input is presented in chunks whose size is not a multiple of
> 16 bytes.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Fixes: fdd2389457b2 ("arm64/crypto: GHASH secure hash using ARMv8 Crypto Extensions")

Both applied. Thanks.

-- 
Catalin
