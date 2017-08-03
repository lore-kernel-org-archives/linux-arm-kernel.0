From: cosardindar@gmail.com (Cosar Dindar)
Date: Thu, 3 Aug 2017 11:44:17 +0300
Subject: [RESEND,PATCH v4 3/3] crypto : stm32 - Add STM32F4 CRC32 support
In-Reply-To: <20170803054423.GA11926@gondor.apana.org.au>
References: <1500280056-46251-1-git-send-email-cosardindar@gmail.com>
 <20170803054423.GA11926@gondor.apana.org.au>
Message-ID: <20170803084417.GA81719@osboxes>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 03, 2017 at 01:44:23PM +0800, Herbert Xu wrote:
> On Mon, Jul 17, 2017 at 11:27:36AM +0300, Cosar Dindar wrote:
> > This patch adds CRC (CRC32 Crypto) support for STM32F4 series.
> > 
> > As an hardware limitation polynomial and key setting are not supported.
> > They are fixed as 0x4C11DB7 (poly) and 0xFFFFFFFF (key).
> > CRC32C Castagnoli algorithm is not used.
> > 
> > Signed-off-by: Cosar Dindar <cosardindar@gmail.com>
> > Reviewed-by: Fabien Dessenne <fabien.dessenne@st.com>
> 
> This patch doesn't apply anymore.  Please rebase.
> 
> Thanks,

OK, I'll rebase and send a new patch including new changes.

Thanks, 

Best Regards,
 
Cosar.

> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
