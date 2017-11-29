From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 29 Nov 2017 17:29:08 +1100
Subject: [PATCH v5 0/2] STM32 CRYP crypto driver
In-Reply-To: <1508425830-13565-1-git-send-email-fabien.dessenne@st.com>
References: <1508425830-13565-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <20171129062908.GA21647@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 19, 2017 at 05:10:28PM +0200, Fabien Dessenne wrote:
> This set of patches adds a new crypto driver for STMicroelectronics stm32 HW.
> This drivers uses the crypto API and provides with HW-enabled block cipher
> algorithms.
> 
> This driver was successfully tested with tcrypt / testmgr.
> 
> Changes since v5:
> -add timeout in wait_busy function
> -clear key after use
> -misc : remove unused functions, use -Exx, use dev_err

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
