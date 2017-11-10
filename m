From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 10 Nov 2017 22:37:20 +1100
Subject: [PATCH v2 1/1] crypto: stm32/hash - Fix return issue on update
In-Reply-To: <1510008112-1573-1-git-send-email-lionel.debieve@st.com>
References: <1510008112-1573-1-git-send-email-lionel.debieve@st.com>
Message-ID: <20171110113720.GC26163@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 11:41:52PM +0100, lionel.debieve at st.com wrote:
> From: Lionel Debieve <lionel.debieve@st.com>
> 
> When data append reached the threshold for processing,
> we must inform that processing is on going to wait before
> managing the next request.
> 
> Signed-off-by: Lionel Debieve <lionel.debieve@st.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
