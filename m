From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 4 Oct 2017 12:06:40 -0700
Subject: [GIT PULL] Amlogic fixes for v4.14-rc
In-Reply-To: <CAOesGMhV0iLP9=YoRhvEmQK7fGpQfhCnoOmsVf8B=+7o4=tuHw@mail.gmail.com>
References: <7hr2ul8na1.fsf@baylibre.com>
 <CAOesGMhV0iLP9=YoRhvEmQK7fGpQfhCnoOmsVf8B=+7o4=tuHw@mail.gmail.com>
Message-ID: <CAOi56cXCnkamsOeKUJJoK7t2wf-M59DM4T_Cxonw=EvBm2F2-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 4, 2017 at 10:32 AM, Olof Johansson <olof@lixom.net> wrote:
> On Mon, Oct 2, 2017 at 10:36 AM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Hi Olof,
>>
>> This is the same DT series that was sent for next/late but was missed,
>> so I'm sending it again as fixes for v4.14-rc since we have some users
>> having issues because the driver was merged for v4.14, but the
>> correspnding DT enhancements were not.
>>
>> Please merge for v4.14-rc3.  It's unmodified since the previous pull request.
>>
>> Thanks,
>>
>> Kevin
>>
>>
>> The following changes since commit 47884c5c746ee7c02e06fbf60480e0f13aa11dfe:
>>
>>   ARM64: dts: meson-gxl-libretech-cc: Add GPIO lines names (2017-08-22 15:37:50 -0700)
>>
>> are available in the git repository at:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-amlogic.git tags/amlogic-dt64-3
>>
>> for you to fetch changes up to 485a308f05d843034b6e82f688704c44888aecde:
>>
>>   ARM64: dts: meson-gxbb: nanopi-k2: enable sdr104 mode (2017-09-05 12:05:01 -0700)
>>
>> ----------------------------------------------------------------
>> Amlogic 64-bit DT updates for v4.14 (round 3)
>> - updates for new MMC driver features/fixes
>> - support high-speed modes
>
> It's really unfortunate that the drivers went in with regressions
> unless the DT contents was updated. That's usually not how we expect
> development to be (by default, previous behavior should be retained if
> DT lacks the data -- it's the only way to stay compatible with older
> bindings).
>
> I've merged this for now anyway, but please be more considerate of
> this going forward. Even if the contents makes it in within the same
> merge window.

Noted, we'll keep a closer eye on that going forward.

Thanks for merging,

Kevin
