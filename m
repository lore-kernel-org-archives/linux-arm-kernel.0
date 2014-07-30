From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Wed, 30 Jul 2014 02:21:53 +0200
Subject: [PATCH v2 2/4] ARM: dts: exynos5250: cypress,cyapa trackpad is
 Snow only
In-Reply-To: <53D82900.1050409@samsung.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>	<1405704009-8430-3-git-send-email-afaerber@suse.de>
 <CAD=FV=VAWG=H9=mwKZfip9zvAROU3aVXihnaBUBr0GNSzDoWFw@mail.gmail.com>
 <53D82900.1050409@samsung.com>
Message-ID: <53D83AA1.7080607@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 30.07.2014 01:06, schrieb Kukjin Kim:
> On 07/30/14 01:16, Doug Anderson wrote:
>> On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber<afaerber@suse.de> 
>> wrote:
>>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>>> Spring does not need it, it uses an Atmel maXTouch instead.
>>>
>>> Signed-off-by: Andreas F?rber<afaerber@suse.de>
>>> ---
>>>   v2: New (Doug Anderson)
>>>
>>>   arch/arm/boot/dts/exynos5250-cros-common.dtsi |  8 --------
>>>   arch/arm/boot/dts/exynos5250-snow.dts         | 10 ++++++++++
>>>   2 files changed, 10 insertions(+), 8 deletions(-)
>>
>> Reviewed-by: Doug Anderson<dianders@chromium.org>
>>
>> Kukjin could apply this now if he wanted to avoid future conflicts.
> 
> OK, I read your comments on another this series and I've applied 1/4 and
> 2/4 as per your suggestion with your reviewed by tag ;)

Thanks.

> And I think, Andreas is going to re-spin remains for exynos5250-spring
> based on updated my -next?

Yes. Please don't apply 3/4, I'm fixing a duplicate hdmi node.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
