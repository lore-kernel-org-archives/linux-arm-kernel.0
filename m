From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jun 2016 10:28:49 -0700
Subject: [PATCH] arm64: defconfig: disable plain NEON implementation of AES
In-Reply-To: <1465829842-3668-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1465829842-3668-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160614172849.GE9200@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 04:57:22PM +0200, Ard Biesheuvel wrote:
> The plain NEON implementation of AES is only suited for v8 cores that lack
> the ARMv8 Crypto Extensions but have an implementation of the NEON tbl/tbx
> instruction that is not pathetically slow. Unfortunately, this is currently
> the empty set, so there is no point in including this implementation by
> default. So disable it.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied, thanks.


-Olof
