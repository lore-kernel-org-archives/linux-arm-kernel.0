From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Mon, 18 Aug 2014 22:13:38 +0200
Subject: [PATCH v5 01/10] ARM: dts: Fix MMC pinctrl for exynos5250-snow
In-Reply-To: <53F25C25.4070602@samsung.com>
References: <1406868897-26874-1-git-send-email-afaerber@suse.de>	<1406868897-26874-2-git-send-email-afaerber@suse.de>
 <CAD=FV=VBa5rs_woj0mshFFbA69Nhyi3hXK_XX7-54T3vFyKYHA@mail.gmail.com>
 <53F247E2.2070007@samsung.com> <53F24A80.4000607@gmail.com>
 <53F25C25.4070602@samsung.com>
Message-ID: <53F25E72.4080205@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 18.08.2014 22:03, schrieb Kukjin Kim:
> On 08/18/14 13:48, Tomasz Figa wrote:
>> On 18.08.2014 20:37, Kukjin Kim wrote:
>>> On 08/01/14 11:26, Doug Anderson wrote:
>>>> On Thu, Jul 31, 2014 at 9:54 PM, Andreas F?rber<afaerber@suse.de>  
>>>> wrote:
>>>>> The pinctrl properties should be on the device directly and not on the
>>>>> slot sub-node.
>>>>>
>>>>> Reported-by: Doug Anderson<dianders@chromium.org>
>>>>> Cc: Jaehoon Chung<jh80.chung@samsung.com>
>>>>> Reviewed-by: Tomasz Figa<t.figa@samsung.com>
>>>>> Signed-off-by: Andreas F?rber<afaerber@suse.de>
>>>>
>>>> Let's land this one before Jaehoon's, since it was a hidden
>>>> functionality change in his patch.  It will be an easy conflict to
>>>> resolve when his patch is applied.
>>>>
>>> Sounds good to me, I've applied this before Jaehoon's change.
>>>
>>>> Reviewed-by: Doug Anderson<dianders@chromium.org>
>>
>> Version 6 of this series has been already posted. However this
>> particular patch has not changed, so it's fine.
>>
> Oh, got it. Hope this and 2nd should be same with version 6 ;)

It is documented as such. :) Others did have changes, of course.

I've started looking into rebasing myself: beware that the smdk5250
cleanup has an additional conflict in the spi node (cs-gpios movement).

http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/commit/arch/arm/boot/dts/exynos5250-smdk5250.dts?h=v3.18-next/dt-samsung&id=e138d4333aa02a3daa12c04192bc5c842bffee74

Thanks,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
