From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 12:47:19 +0100
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org>
 <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
 <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
Message-ID: <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 12:31, Bartosz Golaszewski wrote:
> About that: there are no users of nvmem_device_cell_read/write()
> currently and with the new API I'm not sure this is still needed. Are
> you alright with removing those two?

Why do you want to remove them? Other than reason of no users.

All it boils down to if we support device based apis using cell info or 
not?
IMO, I see no harm in leaving these apis as it is, unless there is a 
strong reason to do so.

thanks,
srini
