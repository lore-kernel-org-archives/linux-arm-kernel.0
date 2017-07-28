From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 28 Jul 2017 21:50:06 +0800
Subject: [PATCH 0/3] STM32 CRC update
In-Reply-To: <1499951193-14842-1-git-send-email-lionel.debieve@st.com>
References: <1499951193-14842-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20170728135006.GC21401@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:06:30PM +0200, Lionel Debieve wrote:
> This set of patches update the STM32 CRC driver.
> It contains two corrections and one global Kconfig rework.
> First correction is about the relaxed usage in scope of arm
> platform usage, second about a unbind driver issue.
> Last patch is about a Kconfig rework that make configuration
> generic for STM32 crypto algos, HASH and CRYP are pushed
> accordingly.
> 
> Lionel Debieve (3):
>   crypto: stm32 - CRC use relaxed function
>   crypto: stm32 - solve crc issue during unbind
>   crypto: stm32 - Rename module to use generic crypto

All patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
