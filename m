From: hch@lst.de (Christoph Hellwig)
Date: Mon, 15 Jan 2018 10:10:02 +0100
Subject: [PATCH 10/22] swiotlb: refactor coherent buffer allocation
In-Reply-To: <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
References: <20180110080932.14157-1-hch@lst.de>
 <20180110080932.14157-11-hch@lst.de>
 <cecc98cf-2e6a-a7bc-7390-d6dcced038c4@arm.com>
 <20180110154649.GA18529@lst.de>
 <03c25dda-30da-9169-a8a1-1720ec741b9d@arm.com>
Message-ID: <20180115091002.GA398@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 10, 2018 at 05:02:30PM +0000, Robin Murphy wrote:
>>>
>>> Aren't we leaking the pages here?
>>
>> Yes, that free_pages got lost somewhere in the rebases, I've added
>> it back.
>
> Cool.

FYI, here is the fixed version, I don't want to re-send the whole
series for this fix:

http://git.infradead.org/users/hch/misc.git/commitdiff/0176adb004065d6815a8e67946752df4cd947c5b
