From: dianders@chromium.org (Doug Anderson)
Date: Fri, 25 Jul 2014 09:02:41 -0700
Subject: [PATCH v2 1/4] ARM: dts: exynos5250: max77686 is Snow only
In-Reply-To: <53D27804.40601@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-2-git-send-email-afaerber@suse.de>
 <08fe01cfa7c9$341cc700$9c565500$@samsung.com>
 <CAD=FV=VUkU7HWjwCKO=WOrKosUtmv3YE_8pxc5uoQg0cHr-AKQ@mail.gmail.com>
 <CAD=FV=VeBP=1CiKesp738anZzSJNZCGkg68RBUUCyJ5U6_Y75w@mail.gmail.com>
 <53D27804.40601@suse.de>
Message-ID: <CAD=FV=WpT28oz9XYRNP2w4y_eZESvuN4QaRfR=Q8wPM75inJ+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Jul 25, 2014 at 8:30 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Doug,
>
> Am 25.07.2014 17:13, schrieb Doug Anderson:
>> On Fri, Jul 25, 2014 at 8:08 AM, Doug Anderson <dianders@chromium.org> wrote:
>>> On Thu, Jul 24, 2014 at 10:28 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>>> Andreas F?rber wrote:
>>>>>
>>>>> Move it from exynos5250-cros-common.dtsi to exynos5250-snow.dts.
>>>>> Spring does not need it, it uses an s5m8767 instead.
>>>>>
>>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>>> ---
>>>>
>>>> Doug, can you have a look this series for exynos5250-chromebook?
>>>> I'm not sure exynos5250-cros-common is still useful for exynos5250-spring...
>>>
>>> Right.  The current suggestion is to rework to just duplicate things
>>> and don't use exynos5250-cros-common.
>>
>> Oh, it actually looks like your patch series ends up there, but the
>> first patch confused me.
>
> NP, guess you just started reading in the middle. ;)

Yeah, I had this on my list to look at but ended up looking at this
one first due to Kukjin's response.


>>  Why move just the maxim PMIC first?
>
> Review of the movements surely is easier this way, and it did not yet
> seem a done deal that we would drop -cros-common. The merge patch nicely
> shows which common parts need to be copied into spring.

That's fine.  I can review it this way now that I realize what's going on.
