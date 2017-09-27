From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 27 Sep 2017 16:55:13 +0200
Subject: [GIT PULL] Amlogic 64-bit DT updates for 4.14 (round 3, late)
In-Reply-To: <CAOesGMjKjAE=OOcOK0KRzwvBO8NS2+qB7bt5zK19ryLopZhT-Q@mail.gmail.com>
 (Olof Johansson's message of "Fri, 15 Sep 2017 14:59:14 -0700")
References: <7hr2vlarbn.fsf@baylibre.com>
 <CAOesGMjKjAE=OOcOK0KRzwvBO8NS2+qB7bt5zK19ryLopZhT-Q@mail.gmail.com>
Message-ID: <7h8th06vji.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

Olof Johansson <olof@lixom.net> writes:

> On Tue, Sep 5, 2017 at 12:17 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> Olof, Arnd,
>>
>> I'm aware this is pretty late, so feel free to include in a late branch,
>> or we can wait and send after -rc1.  It's late because the corresponding
>> drivers/mmc change just got merged.
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
> I decided to merge into next/late, will send this afternoon or
> tomorrow together with a few other changes.

hmm, it doesn't look like this made it into -rc1 or -rc2.  Were there
any problems?

Kevin
