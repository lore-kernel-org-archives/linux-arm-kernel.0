From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 28 Oct 2013 08:03:56 -0700
Subject: [PATCH v2 00/12] clk/exynos convert clock IDs to macros
In-Reply-To: <526E7553.8030607@samsung.com>
References: <1378462361-13680-1-git-send-email-a.hajda@samsung.com>
 <8412301.YP2zzplWoe@amdc1227>
 <070001ceafa5$d4d81a40$7e884ec0$%kim@samsung.com>
 <523716C9.3000204@samsung.com> <20130916193709.27384.86101@quantum>
 <06c101cebdc5$75a83d10$60f8b730$%kim@samsung.com>
 <20131002010953.9338.23436@quantum>
 <0d8901cec170$f7230b50$e56921f0$%kim@samsung.com>
 <20131006202709.32214.75572@quantum> <525274FA.5020701@samsung.com>
 <526E7553.8030607@samsung.com>
Message-ID: <526E7CDC.3070306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/28/13 07:31, Andrzej Hajda wrote:
> Ping
>
> Regards
> Andrzej
>
> On 10/07/2013 10:46 AM, Andrzej Hajda wrote:
>> On 10/06/2013 10:27 PM, Mike Turquette wrote:
>>> Quoting Kukjin Kim (2013-10-04 19:16:56)
>>>> Mike Turquette wrote:
>>>>> Quoting Kukjin Kim (2013-09-30 03:11:41)
>>>>>> Mike Turquette wrote:
>>>>>>> Quoting Sylwester Nawrocki (2013-09-16 07:33:45)
>>>>>>>> On 09/12/2013 12:50 PM, Kukjin Kim wrote:
>>>>>>>>> Well...I'm not sure changing to use macro is better or not at this
>>>>>>> moment...
>>>>>>>> I think it is. ;) It's really less error prone to have symbolic
>>>>> names
>>>>>>> instead
>>>>>>>> of the plain numbers. The clock ids are defined in one place and it
>>>>> is
>>>>>>> more
>>>>>>>> clear what a clock is by looking at symbolic name. It's especially
>>>>>>> annoying
>>>>>>>> to use plain numbers where are are many clock in a single node, like
>>>>> 10
>>>>>>> or
>>>>>>>> more. What are you main concerns with this ?
>>>>>>> I think having the symbolic names is a win for readability.
>>>>>>>
>>>>>> Hmm...since Mike who is a maintainer for ccf agrees with Sylwester's
>>>>> opinion, so I agree. Actually, I had no strong objection on this but still
>>>>> I'm not sure using macro is really better because sometimes the name
>>>>> doesn't give readability really I think though.
>>>>>> Mike, can you give me your ack on clk stuff?
>>>>> Yes, but I was thinking to take this change through the clk tree. The
>>>>> new branch based on -rc3 will be published tonight.
>>>>>
>>>>> Let me know if it causes problems for you for me to take it.
>>>>>
>>>> Uhm, I think dt changes can make ugly conflicts because of spread dt changing?
>>> Sure, go ahead and take the patches then.
>>>
>>> Acked-by: Mike Turquette<mturquette@linaro.org>
>>>
>>> Regards,
>>> Mike
>>
>> I can create patchset based on different git branch if neccessary.
>>
Hi

Unfortunately, this changes would be merged after release of next rc1 
because of too many conflicts with other DT changes in Samsung tree.

Thanks,
Kukjin
