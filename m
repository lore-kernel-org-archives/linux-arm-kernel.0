From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 5 Apr 2017 22:09:29 +0800
Subject: [PATCH v2 0/5] STM32 CRC crypto driver
In-Reply-To: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
References: <1490109211-4869-1-git-send-email-fabien.dessenne@st.com>
Message-ID: <20170405140929.GD27150@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 21, 2017 at 04:13:26PM +0100, Fabien Dessenne wrote:
> This set of patches adds a new crypto driver for STMicroelectronics stm32f746.
> The drivers uses the crypto API and provides with an HW-enabled CRC32 algorithm.
> It was developed and tested (tcrypt / testmgr) on evaluation board stm32746g.
> 
> v2 changes:
> - remove useless check of crc / crc->clk
> - enable crypto in stm32 defconfig
> - typo fix in dt-bindings

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
