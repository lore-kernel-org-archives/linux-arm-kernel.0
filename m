From: dvyukov@google.com (Dmitry Vyukov)
Date: Mon, 19 Mar 2018 09:43:48 +0100
Subject: [PATCH v2 0/7] KASan for arm
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0076FFD@dggemm510-mbs.china.huawei.com>
References: <B8AC3E80E903784988AB3003E3E97330C0076FFD@dggemm510-mbs.china.huawei.com>
Message-ID: <CACT4Y+bec8x8AZOneZ57bnxei=gBGGKG2_VUiqyMaa1OPzov2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 19, 2018 at 2:56 AM, Liuwenliang (Abbott Liu)
<liuwenliang@huawei.com> wrote:
> On 03/19/2018 09:23 AM, Florian Fainelli wrote:
>>On 03/18/2018 06:20 PM, Liuwenliang (Abbott Liu) wrote:
>>> On 03/19/2018 03:14 AM, Florian Fainelli wrote:
>>>> Thanks for posting these patches! Just FWIW, you cannot quite add
>>>> someone's Tested-by for a patch series that was just resubmitted given
>>>> the differences with v1. I just gave it a spin on a Cortex-A5 (no LPAE)
>>>> and it looks like test_kasan.ko is passing, great job!
>>>
>>> I'm sorry.
>>> Thanks for your testing very much!
>>> I forget to add Tested-by in cover letter patch file. But I have alreadly added
>>> Tested-by in some of following patch.
>>> In the next version I am going to add Tested-by in all patches.
>>
>>This is not exactly what I meant. When you submit a v2 of your patches,
>>you must wait for people to give you their test results. The Tested-by
>>applied to v1, and so much has changed it is no longer valid for v2
>>unless someone tells you they tested v2. Hope this is clearer.
>
> Ok, I understand now. thank you for your explanation.


Hi Abbott,

I've skimmed through the changes and they generally look good to me. I
am not an expect in arm, so I did not look too closely on these parts
(which is actually most of the changes).

FWIW
Acked-by: Dmitry Vyukov <dvyukov@google.com>

Please also update set of supported archs at the top of
Documentation/dev-tools/kasan.rst

Thanks for working on upstreaming this!
