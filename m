From: dianders@chromium.org (Doug Anderson)
Date: Fri, 25 Jul 2014 08:13:07 -0700
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <CAD=FV=VUkU7HWjwCKO=WOrKosUtmv3YE_8pxc5uoQg0cHr-AKQ@mail.gmail.com>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-2-git-send-email-afaerber@suse.de>
 <08fe01cfa7c9$341cc700$9c565500$@samsung.com>
 <CAD=FV=VUkU7HWjwCKO=WOrKosUtmv3YE_8pxc5uoQg0cHr-AKQ@mail.gmail.com>
Message-ID: <CAD=FV=VeBP=1CiKesp738anZzSJNZCGkg68RBUUCyJ5U6_Y75w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Jul 25, 2014 at 8:08 AM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Thu, Jul 24, 2014 at 10:28 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>> Andreas F?rber wrote:
>>>
>>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>>> Spring does not need it, it uses an s5m8767 instead.
>>>
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>> ---
>>
>> Hi Andreas,
>>
>> I think this should be reviewed by chrome guys.
>>
>>
>> Doug, can you have a look this series for exynos5250-chromebook?
>> I'm not sure exynos5250-cros-common is still useful for exynos5250-spring...
>
> Sorry, I've been on vacation and am now playing catchup.
>
> Right.  The current suggestion is to rework to just duplicate things
> and don't use exynos5250-cros-common.

Oh, it actually looks like your patch series ends up there, but the
first patch confused me.  Why move just the maxim PMIC first?  Move
everything at once and be done with the common file, then do
cleanup...
