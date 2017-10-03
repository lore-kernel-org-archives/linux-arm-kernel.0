From: fabien.dessenne@st.com (Fabien DESSENNE)
Date: Tue, 3 Oct 2017 07:48:08 +0000
Subject: [PATCH v3 1/3] crypto: engine - permit to enqueue aead_request
In-Reply-To: <20170922090921.GA15677@gondor.apana.org.au>
References: <1503047946-27799-1-git-send-email-fabien.dessenne@st.com>
 <1503047946-27799-2-git-send-email-fabien.dessenne@st.com>
 <20170922090921.GA15677@gondor.apana.org.au>
Message-ID: <20206811-7075-5ca9-98cd-26a5709751fb@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/09/17 11:09, Herbert Xu wrote:
> On Fri, Aug 18, 2017 at 11:19:04AM +0200, Fabien Dessenne wrote:
>> The current crypto engine allows ablkcipher_request and ahash_request to
>> be enqueued. Extend this to aead_request.
>>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> I'd like to see the crypto_engine interface cleaned up a little
> before we expand it further.  Please refer to
>
> https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
>
> Thanks,
It looks like there is no more activity around this "crypto_engine 
interface clean up" task.
This unfortunately has been blocking the introduction of this new STM32 
crypto driver for 3 months now.
Would it make sense to have this driver reviewed first, and then 
reworked (I expect minor update here) when the interface update is ready?

BR

Fabien
