From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 09:09:20 +0100
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
Message-ID: <7e138142-8161-3646-4daf-619995baf395@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 08:58, Bartosz Golaszewski wrote:
> 2018-09-10 9:32 GMT+02:00 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>:
>>
>>
>> On 07/09/18 11:07, Bartosz Golaszewski wrote:
>>>
>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>>
>>> Remove all APIs dealing with nvmem_cell_info. There are no users and
>>> this part of the subsystem will be reworked.
>>>
>>> This patch temprarily disables support for non-DT users.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>    drivers/nvmem/core.c           | 212 ++-------------------------------
>>>    include/linux/nvmem-consumer.h |  26 ----
>>>    include/linux/nvmem-provider.h |  13 --
>>>    3 files changed, 12 insertions(+), 239 deletions(-)
>>
>>
>> This looks totally un-necessary, Other patches in this series adds them
>> back.. Consider updating these in those respective patches.!
>>
> 
> While this may not be entirely necessary, it's very useful. There's
Yes, thats exactly what am saying if it not necessary please do not do it.

> almost nothing common between this API and the new one added later in
There is more than 60%-70% of the code reused in new patches, which is 
unnecessary churn to me!

> this series. Later patches are MUCH cleaner thanks to this removal and
> I believe it makes them easier for review.
Am not sure about that, it definitely did not help me!

--srini
> 
> Best regards,
> Bart
> 
