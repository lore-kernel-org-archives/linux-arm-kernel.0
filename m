From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 21 Feb 2014 08:31:27 +0800
Subject: [PATCH v3] hwrng: msm: switch Kconfig to ARCH_QCOM depends
In-Reply-To: <1392933533-10191-1-git-send-email-galak@codeaurora.org>
References: <1392933533-10191-1-git-send-email-galak@codeaurora.org>
Message-ID: <20140221003127.GA24448@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 03:58:53PM -0600, Kumar Gala wrote:
> We've split Qualcomm MSM support into legacy and multiplatform.  The RNG
> driver is only relevant on the multiplatform supported SoCs so switch the
> Kconfig depends to ARCH_QCOM.
> 
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: Stanimir Varbanov <svarbanov@mm-sol.com>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
