From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 9 Jul 2018 00:43:59 +0800
Subject: [PATCH 0/3] crypto: stm32 - Add power mamagement support
In-Reply-To: <1530017566-14779-1-git-send-email-lionel.debieve@st.com>
References: <1530017566-14779-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20180708164358.qfgj5maijnetucj7@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 02:52:43PM +0200, Lionel Debieve wrote:
> This set of patches add pm and pm_runtime feature to stm32 crypto
> drivers.
> 
> Lionel Debieve (3):
>   crypto: stm32/cryp - Add power management support
>   crypto: stm32/hash - Add power management support
>   crypto: stm32/crc - Add power management support
> 
>  drivers/crypto/stm32/stm32-cryp.c  | 62 +++++++++++++++++++++++++++++++++
>  drivers/crypto/stm32/stm32-hash.c  | 71 ++++++++++++++++++++++++++++++++++++++
>  drivers/crypto/stm32/stm32_crc32.c | 62 +++++++++++++++++++++++++++++++++
>  3 files changed, 195 insertions(+)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
