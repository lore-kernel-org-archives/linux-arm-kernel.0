From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 6 Oct 2015 23:24:21 +0800
Subject: [RESEND 1/3] hwrng: st: dt: Fix trivial typo in node address
In-Reply-To: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
References: <1444142640-14721-1-git-send-email-lee.jones@linaro.org>
Message-ID: <20151006152421.GA5997@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 03:43:58PM +0100, Lee Jones wrote:
> DT nodes should not append their addresses with '0x'.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

If this is supposed to go in via the crypto tree it needs to be
posted to linux-crypto at vger.kernel.org.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
