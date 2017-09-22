From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 22 Sep 2017 17:09:21 +0800
Subject: [PATCH v3 1/3] crypto: engine - permit to enqueue aead_request
In-Reply-To: <1503047946-27799-2-git-send-email-fabien.dessenne@st.com>
References: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
 <1503047946-27799-2-git-send-email-fabien.dessenne@st.com>
Message-ID: <20170922090921.GA15677@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 11:19:04AM +0200, Fabien Dessenne wrote:
> The current crypto engine allows ablkcipher_request and ahash_request to
> be enqueued. Extend this to aead_request.
> 
> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>

I'd like to see the crypto_engine interface cleaned up a little
before we expand it further.  Please refer to

https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
