From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 31 Jan 2017 16:36:51 -0800
Subject: [PATCH 1/3] mmc: meson-gx: fix setting f_min
In-Reply-To: <CAOi56cWgZ7y3m9YSA82dzw=KHTntk-i1bxeT8Hf=_+Jb=5_P1w@mail.gmail.com>
References: <e26a74f8-9819-6940-4c90-225377cc0a3e@gmail.com>
 <CAPDyKFrhTm7A_tq_W3yWoPv95exZ-LTtEhiQhw134AfGZuRY+Q@mail.gmail.com>
 <d974bc57-1959-e16e-eb89-0e1dc37d8f15@gmail.com>
 <CAOi56cWgZ7y3m9YSA82dzw=KHTntk-i1bxeT8Hf=_+Jb=5_P1w@mail.gmail.com>
Message-ID: <CAOi56cV8SKtcPArZiMk+oKoyPV-rpswhDDf6bPzt9EJC4s6HjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 31, 2017 at 2:44 PM, Kevin Hilman <khilman@baylibre.com> wrote:
> On Tue, Jan 31, 2017 at 12:32 PM, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>> Am 31.01.2017 um 12:55 schrieb Ulf Hansson:
>>> On 26 January 2017 at 22:41, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
>>>> I think the itention is to set f_min to 400 kHz.
>>>> Change value and comment accordingly.
>>>>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>
>>> Heiner, could you please collect the mmc meson changes that you
>>> recently have submitted in one series and re-post to linux-mmc. I can
>>> pick them up from there.
>>>
>> Sure. Apart from the ones you've reviewed already I have few more.
>> I'll add them to the patch set.
>
> When you re-post, it's customary to collect and add the various tags
> (acked-by, tested-by, reviewed-by) to the changelog so it's easy to
> tell what's already been reviewed/acked etc.

Also, please be sure to Cc the linux-amlogic list.

Thanks,

Kevin
