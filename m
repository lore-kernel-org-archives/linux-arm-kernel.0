From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jul 2014 08:06:40 +0900
Subject: [PATCH v2 2/4] ARM: dts: exynos5250: cypress,cyapa trackpad is
 Snow only
In-Reply-To: <CAD=FV=VAWG=H9=mwKZfip9zvAROU3aVXihnaBUBr0GNSzDoWFw@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>	<1405704009-8430-3-git-send-email-afaerber@suse.de>
 <CAD=FV=VAWG=H9=mwKZfip9zvAROU3aVXihnaBUBr0GNSzDoWFw@mail.gmail.com>
Message-ID: <53D82900.1050409@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/30/14 01:16, Doug Anderson wrote:
> Andreas,
>
> On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber<afaerber@suse.de>  wrote:
>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>> Spring does not need it, it uses an Atmel maXTouch instead.
>>
>> Signed-off-by: Andreas F?rber<afaerber@suse.de>
>> ---
>>   v2: New (Doug Anderson)
>>
>>   arch/arm/boot/dts/exynos5250-cros-common.dtsi |  8 --------
>>   arch/arm/boot/dts/exynos5250-snow.dts         | 10 ++++++++++
>>   2 files changed, 10 insertions(+), 8 deletions(-)
>
> Reviewed-by: Doug Anderson<dianders@chromium.org>
>
> Kukjin could apply this now if he wanted to avoid future conflicts.

OK, I read your comments on another this series and I've applied 1/4 and 
2/4 as per your suggestion with your reviewed by tag ;)

And I think, Andreas is going to re-spin remains for exynos5250-spring 
based on updated my -next?

Thanks,
Kukjin
