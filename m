From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 15 Feb 2018 23:53:02 +0800
Subject: [PATCH 0/2] crypto: stm32/cryp - add AEAD cipher algorithms
In-Reply-To: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
References: <1518008935-30428-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <20180215155302.GQ7352@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 07, 2018 at 02:08:53PM +0100, Fabien Dessenne wrote:
> This patchset depends on "crypto: engine - Permit to enqueue all async requests"
> proposed by Corentin Labbe [https://lkml.org/lkml/2018/1/26/608].
> stm32-cryp uses this updated crpyto engine to handle AEAD cipher algortihms.
> 
> Fabien Dessenne (2):
>   crypto: stm32/cryp - add aes gcm / ccm support
>   crypto: stm32/cryp - add stm32mp1 support

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
