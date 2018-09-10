From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 10:55:23 +0100
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org>
 <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
Message-ID: <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 09:43, Bartosz Golaszewski wrote:
>>> this series. Later patches are MUCH cleaner thanks to this removal and
>>> I believe it makes them easier for review.
>> Am not sure about that, it definitely did not help me!
>>
> Why exactly? Aren't clean patches resulting from this removal easier
> to read then if they'd also have to take into account the burden of
> existing code that will be changes anyway later? I really don't see
> why you insist on removing this.

Here are few reasons:

1> TBH, This cleanup patch removes more than one feature from nvmem 
subsystem.
Ex: it remove ability to add static cell from nvmem config, secondly it 
removed ability to read/write cells directly using nvmem_cell_info.

2> If you do changes as part of each patch, it will be much traceable on 
what is changed exactly and will allow much better review, and 
understand the reasoning.

Having a clean start and writing code on top of it is alway nice, but we 
will definitely miss things in review in this particular instance.


thanks,
srini

> 
> Best regards,
> Bart
> 
