From: olof@lixom.net (Olof Johansson)
Date: Thu, 13 Feb 2014 12:19:50 -0800
Subject: [PATCH 2/3] arm64: Add Kconfig option for Samsung GH7 SoC family
In-Reply-To: <CAL_JsqJ5FHt4HoV2NtU1ddFpcdxi=Jji0-mPSXL872P8fXrCuQ@mail.gmail.com>
References: <1392100183-30930-1-git-send-email-kgene.kim@samsung.com>
 <1392100183-30930-3-git-send-email-kgene.kim@samsung.com>
 <CAOesGMiWsWXkQkb-_VZGco0gKNZPsHf3ubR88y4Pt4-umk5_Ww@mail.gmail.com>
 <CAL_JsqJ5FHt4HoV2NtU1ddFpcdxi=Jji0-mPSXL872P8fXrCuQ@mail.gmail.com>
Message-ID: <CAOesGMgKTctn4aHpvsqzWpgocgmD0vQb9e508sm48jt9PtH6RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 13, 2014 at 12:08 PM, Rob Herring <robherring2@gmail.com> wrote:
> On Tue, Feb 11, 2014 at 5:39 PM, Olof Johansson <olof@lixom.net> wrote:
>> On Mon, Feb 10, 2014 at 10:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
>>> This patch adds support for Samsung GH7 SoC in arm64/Kconfig.
>>>
>>> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
>>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>>
>> The overhead of building one more device tree isn't very large, and I
>> don't see any other need to have a Kconfig entry per SoC at this time.
>> It's of course up to Catalin, but you might just want to always
>> compile all dts files instead.
>
> I think having "make dtbs" build all regardless of the config would be
> better.

We can do that too, but that doesn't mean it's useful to have this
kconfig entry.

> Perhaps a "all_dtbs" target could be added and everyone can
> get what they want. If/when we add checking into dtc, this we
> certainly become more desirable.


-Olof
