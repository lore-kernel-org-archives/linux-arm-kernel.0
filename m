From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 22 Sep 2017 18:13:23 +0800
Subject: [PATCH 1/1] crypto: stm32/hash - Remove uninitialized symbol
In-Reply-To: <1503064441-19964-1-git-send-email-lionel.debieve@st.com>
References: <1503064441-19964-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20170922101323.GE16270@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 03:54:01PM +0200, Lionel Debieve wrote:
> Remove err symbol as this is not used in the thread context
> and the variable is not initialized.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
