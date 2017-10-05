From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 5 Oct 2017 11:39:25 +0800
Subject: [PATCH v3 1/3] crypto: engine - permit to enqueue aead_request
In-Reply-To: <20206811-7075-5ca9-98cd-26a5709751fb@st.com>
References: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
 <1503047946-27799-2-git-send-email-fabien.dessenne@st.com>
 <20170922090921.GA15677@gondor.apana.org.au>
 <20206811-7075-5ca9-98cd-26a5709751fb@st.com>
Message-ID: <20171005033925.GA31996@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 03, 2017 at 07:48:08AM +0000, Fabien DESSENNE wrote:
>
> It looks like there is no more activity around this "crypto_engine 
> interface clean up" task.
> This unfortunately has been blocking the introduction of this new STM32 
> crypto driver for 3 months now.
> Would it make sense to have this driver reviewed first, and then 
> reworked (I expect minor update here) when the interface update is ready?

Hmm, is it possible to disable the AEAD part of the driver first?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
