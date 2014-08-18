From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Aug 2014 15:03:49 -0500
Subject: [PATCH v5 01/10] ARM: dts: Fix MMC pinctrl for exynos5250-snow
In-Reply-To: <53F24A80.4000607@gmail.com>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>	<1406868897-26874-2-git-send-email-afaerber@suse.de>
 <CAD=FV=VBa5rs_woj0mshFFbA69Nhyi3hXK_XX7-54T3vFyKYHA@mail.gmail.com>
 <53F247E2.2070007@samsung.com> <53F24A80.4000607@gmail.com>
Message-ID: <53F25C25.4070602@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/18/14 13:48, Tomasz Figa wrote:
> Hi Kukjin,
>
Hi,

> On 18.08.2014 20:37, Kukjin Kim wrote:
>> On 08/01/14 11:26, Doug Anderson wrote:
>>> Hi,
>>>
>> Hi,
>>
>>> On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber<afaerber@suse.de>   wrote:
>>>> The pinctrl properties should be on the device directly and not on the
>>>> slot sub-node.
>>>>
>>>> Reported-by: Doug Anderson<dianders@chromium.org>
>>>> Cc: Jaehoon Chung<jh80.chung@samsung.com>
>>>> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>>>> Signed-off-by: Andreas F?rber<afaerber@suse.de>
>>>
>>> Let's land this one before Jaehoon's, since it was a hidden
>>> functionality change in his patch.  It will be an easy conflict to
>>> resolve when his patch is applied.
>>>
>> Sounds good to me, I've applied this before Jaehoon's change.
>>
>>> Reviewed-by: Doug Anderson<dianders@chromium.org>
>
> Version 6 of this series has been already posted. However this
> particular patch has not changed, so it's fine.
>
Oh, got it. Hope this and 2nd should be same with version 6 ;)

Thanks.

- Kukjin
