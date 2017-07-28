From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 28 Jul 2017 21:50:18 +0800
Subject: [PATCH 0/2] STM32 HASH crypto driver
In-Reply-To: <1499952747-16423-1-git-send-email-lionel.debieve@st.com>
References: <1499952747-16423-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20170728135018.GD21401@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 13, 2017 at 03:32:25PM +0200, Lionel Debieve wrote:
> This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
> This drivers uses the crypto API and provides with HW-enabled md5, sha1,
> sha224, sha256 hash based algorithms.
> It makes use of the crypto engine to support ahash requests.
> 
> This driver was successfully tested with tcrypt / testmgr.
> 
> Note:
> Since two other set of patches (update of STM32 CRC32 and addition of STM32
> CRYP) are being proposed, it may happen that there are some minor conflicts in
> 'Kconfig' and 'Makefile'. In that case, I will fix the issue in due course.
> 
> Lionel Debieve (2):
>   dt-bindings: Document STM32 HASH bindings
>   crypto: stm32 - Support for STM32 HASH module

All patches applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
