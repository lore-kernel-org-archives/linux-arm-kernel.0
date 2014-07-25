From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 17:30:12 +0200
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <CAD=FV=VeBP=1CiKesp738anZzSJNZCGkg68RBUUCyJ5U6_Y75w@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>	<1405704009-8430-2-git-send-email-afaerber@suse.de>	<08fe01cfa7c9$341cc700$9c565500$@samsung.com>	<CAD=FV=VUkU7HWjwCKO=WOrKosUtmv3YE_8pxc5uoQg0cHr-AKQ@mail.gmail.com>
 <CAD=FV=VeBP=1CiKesp738anZzSJNZCGkg68RBUUCyJ5U6_Y75w@mail.gmail.com>
Message-ID: <53D27804.40601@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

Am 25.07.2014 17:13, schrieb Doug Anderson:
> On Fri, Jul 25, 2014 at 8:08 AM, Doug Anderson <dianders@chromium.org> wrote:
>> On Thu, Jul 24, 2014 at 10:28 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>> Andreas F?rber wrote:
>>>>
>>>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>>>> Spring does not need it, it uses an s5m8767 instead.
>>>>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>
>>> Doug, can you have a look this series for exynos5250-chromebook?
>>> I'm not sure exynos5250-cros-common is still useful for exynos5250-spring...
>>
>> Right.  The current suggestion is to rework to just duplicate things
>> and don't use exynos5250-cros-common.
> 
> Oh, it actually looks like your patch series ends up there, but the
> first patch confused me.

NP, guess you just started reading in the middle. ;)

>  Why move just the maxim PMIC first?

Review of the movements surely is easier this way, and it did not yet
seem a done deal that we would drop -cros-common. The merge patch nicely
shows which common parts need to be copied into spring.

>  Move
> everything at once and be done with the common file, then do
> cleanup...

If everyone agrees that we want to proceed that way, we can easily
squash patches 1+2. Separating is always harder.

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
