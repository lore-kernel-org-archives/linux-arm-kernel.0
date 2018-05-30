From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 31 May 2018 00:28:04 +0800
Subject: [PATCH v2 0/5] crypto: ccree: cleanup, fixes and R-Car enabling
In-Reply-To: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
References: <1527171551-21979-1-git-send-email-gilad@benyossef.com>
Message-ID: <20180530162804.zp4n22nprqmigywz@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2018 at 03:19:05PM +0100, Gilad Ben-Yossef wrote:
> The patch set enables the use of CryptoCell found in some Renesas R-Car
> Salvator-X boards and fixes some driver issues uncovered that prevented
> to work properly.
> 
> Changes from v1:
> - Properly fix the bug that caused us to read a bad signature register
>   rather than dropping the check
> - Proper DT fields as indicated by Geert Uytterhoeven.
> - Better clock enabling as suggested by Geert Uytterhoeven.
> 
> Note! the last two patches in the set depend on the
> "clk: renesas: r8a7795: Add CR clock" patch from Geert Uytterhoeven.

Patches 1-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
