From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Fri, 6 Oct 2017 09:26:07 +0000
Subject: [PATCH v3 1/3] crypto: engine - permit to enqueue aead_request
In-Reply-To: <20171005033925.GA31996@gondor.apana.org.au>
References: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
 <1503047946-27799-2-git-send-email-fabien.dessenne@st.com>
 <20170922090921.GA15677@gondor.apana.org.au>
 <20206811-7075-5ca9-98cd-26a5709751fb@st.com>
 <20171005033925.GA31996@gondor.apana.org.au>
Message-ID: <9d89727b-f3cb-3322-6513-962e9df63ca8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, I will send an initial version without the AEAD part.


On 05/10/17 05:39, Herbert Xu wrote:
> On Tue, Oct 03, 2017 at 07:48:08AM +0000, Fabien DESSENNE wrote:
>> It looks like there is no more activity around this "crypto_engine
>> interface clean up" task.
>> This unfortunately has been blocking the introduction of this new STM32
>> crypto driver for 3 months now.
>> Would it make sense to have this driver reviewed first, and then
>> reworked (I expect minor update here) when the interface update is ready?
> Hmm, is it possible to disable the AEAD part of the driver first?
>
> Cheers,
