From: jon.mason@broadcom.com (Jon Mason)
Date: Mon, 17 Apr 2017 15:39:34 -0400
Subject: [PATCH] ARM: dts: BCM5301X: Add CPU thermal sensor and zone
In-Reply-To: <CACna6rwR__iyPO6NcO3STtKz+aXfNiZFsNXhYwTHs27pTrrU9Q@mail.gmail.com>
References: <20170414214228.32521-1-zajec5@gmail.com>
 <CAC3K-4pQNnezT7gk45DoyW5hmZ1Vqshcx-tx-bS6mOVRNUooog@mail.gmail.com>
 <CACna6rwR__iyPO6NcO3STtKz+aXfNiZFsNXhYwTHs27pTrrU9Q@mail.gmail.com>
Message-ID: <CAC3K-4pcA_YjK4rjLDOpkqA-VT02HUkvpTZmB9EqZ0v4N6K_vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 17, 2017 at 12:14 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> On 17 April 2017 at 16:54, Jon Mason <jon.mason@broadcom.com> wrote:
>> On Fri, Apr 14, 2017 at 5:42 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>>> From: Rafa? Mi?ecki <rafal@milecki.pl>
>>>
>>> This uses CPU thermal sensor available on every Northstar chipset to
>>> monitor temperature. We don't have any cooling or throttling so only a
>>> critical trip was added.
>>
>> Haha!  You beat me to it (as I had a similar patch queued).
>>
>> This looks good to me.
>>
>> Acked-by: Jon Mason <jon.mason@broadcom.com>
>
> :) Thanks
>
> I'd appreciate adding thermal to NSP DT. I don't have any NSP unit to
> try it on my own.

I'm doing so right now.  I have it working, I just need to clean up the patches.
