From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 3 Jul 2018 10:12:55 +0530
Subject: [PATCH v7 0/4] ARM: davinci: complete the conversion to using the
 reset framework
In-Reply-To: <345aed22-629a-abf6-df22-adee88a43df6@lechnology.com>
References: <20180621073706.22812-1-brgl@bgdev.pl>
 <9ec10627-49a5-07ad-8c9d-5ac873096cc0@ti.com>
 <CAMRc=Me1JTuw40tMWaai2oKMxmc_ktN2OKBhF8tmGt0cQ6magg@mail.gmail.com>
 <e4bd9f57-617a-a59e-5d05-be1a6b3e6b3d@ti.com>
 <345aed22-629a-abf6-df22-adee88a43df6@lechnology.com>
Message-ID: <03256c00-c23f-68c4-c62b-fb4b85547551@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 July 2018 08:57 PM, David Lechner wrote:
> On 07/02/2018 07:08 AM, Sekhar Nori wrote:
>> Hi Bjorn,
>>
>> On Thursday 21 June 2018 05:11 PM, Bartosz Golaszewski wrote:
>>> 2018-06-21 12:52 GMT+02:00 Sekhar Nori <nsekhar@ti.com>:
>>>> Hi Bartosz,
>>>>
>>>> On Thursday 21 June 2018 01:07 PM, Bartosz Golaszewski wrote:
>>>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>>>
>>>>> These are the remaining patches that still need to be merged in order
>>>>> to complete the conversion of the davinci dsp driver to using the
>>>>> reset
>>>>> framework.
>>>>>
>>>>> They apply on top of v4.18-rc1 with David Lechner's remaining patches
>>>>> merged.
>>>>
>>>> Series looks good to me.
>>>>
>>>> To preserve bisect, shouldn't the order of applying be patch #3, #4, #1
>>>> and #2 ?
>>>>
>>>> Given the dependencies and to preserve bisect its easiest if I take the
>>>> series with acks from remoteproc and clock maintainers.
>>>>
>>>> Open to other suggestions as well.
>>>>
>>>> Thanks,
>>>> Sekhar
>>>
>>> Oops you're right about the order. Do you want me to resend?
>>
>> With your ack, I can queue 1/4 for v4.19 and provide an immutable commit
>> to you (on top of v4.18-rc1) for you to merge any further changes you
>> want to queue from your tree.
>>
>> Bartosz, given the number of moving pieces, I think its better to keep
>> 2/4 for v4.20 release - once all other other dependencies have been
>> merged.
> 
> I was thinking the same thing as well. I will pick it up in a
> clk-davinci-4.20 branch if that sounds OK.

Sounds good. Just check that there really are no users of that API
before queuing :)

Regards,
Sekhar
