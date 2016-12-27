From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 27 Dec 2016 18:06:13 +0800
Subject: [PATCH v3 0/2] Add MediaTek crypto accelerator driver
In-Reply-To: <1482114045-18716-1-git-send-email-ryder.lee@mediatek.com>
References: <1482114045-18716-1-git-send-email-ryder.lee@mediatek.com>
Message-ID: <20161227100613.GG10629@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2016 at 10:20:43AM +0800, Ryder Lee wrote:
> Hello,
> 
> This adds support for the MediaTek hardware accelerator on
> some SoCs.
> 
> This driver currently implement: 
> - SHA1 and SHA2 family(HMAC) hash algorithms.
> - AES block cipher in CBC/ECB mode with 128/196/256 bits keys.
> 
> Chances since v3:
> -remove unused structure member
> -drop interrupt-parent from DT bindings documentation
> 
> Changes since v2:
> - use byteorder conversion macros and type identifiers for descriptors
> - revise register definition macros to make it more clear
> - revise DT compatiable string
> 
> Changes since v1:
> - remove EXPORT_SYMBOL
> - remove unused PRNG setting
> - sort headers in alphabetical order
> - add a definition for IRQ unmber
> - replace ambiguous definition
> - add more annotation and function comment
> - add COMPILE_TEST in Kconfig
> 
> Ryder Lee (2):
>   Add crypto driver support for some MediaTek chips
>   crypto: mediatek - add DT bindings documentation

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
