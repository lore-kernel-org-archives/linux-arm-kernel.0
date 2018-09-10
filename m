From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 10 Sep 2018 14:23:34 +0100
Subject: [PATCH v2 01/16] nvmem: remove unused APIs
In-Reply-To: <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
References: <20180907100750.14564-1-brgl@bgdev.pl>
 <20180907100750.14564-2-brgl@bgdev.pl>
 <c0b0c411-65f6-62f9-6d6d-2884e5a17250@linaro.org>
 <CAMRc=MfO01EQAfY4Uu3UwzzvhVOMF7_BpCOPVz2yVXqDgpb0AA@mail.gmail.com>
 <7e138142-8161-3646-4daf-619995baf395@linaro.org>
 <CAMRc=Mduu4CmLX5DFtJd8NSbzs5g65U9AmM=rbscit0JyQKVAQ@mail.gmail.com>
 <3dbd65e5-c948-a784-0362-930fc41b840e@linaro.org>
 <CAMRc=Mck=rAJ6jbm57ZecJWNvOYR5pjLy0JnyxFzA8kFvoK7Ew@mail.gmail.com>
 <ec2ba4af-46cf-2025-1670-cbed366d0f15@linaro.org>
 <20180910141820.6c715895@bbrezillon>
 <CAMRc=Mdew1s35=M+vh=Fxc--0+rYxRXT96KVOJRhAX9f8QwtkA@mail.gmail.com>
Message-ID: <d74205d4-f8c1-1151-413b-e1a80aa6b74c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/09/18 13:22, Bartosz Golaszewski wrote:
> While one can argue that nvmem_device_cell_read/write() may be needed
> in some strange corner case now, once we add the cell lookup API, we
> can safely remove it and force users to do the right thing.
I agree!

I don't have very strong reason to stop removing 
nvmem_device_cell_read/write().
Lets see how it turns out!

I would still want nvmem config to have ability to setup static cell list.

--srini
