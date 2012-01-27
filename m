From: eranian@googlemail.com (stephane eranian)
Date: Fri, 27 Jan 2012 13:45:11 +0100
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120127121311.GB2347@mudshark.cambridge.arm.com>
References: <CACVXFVPnhSy_DbdK+ro8G78QjL2s6fBBq1Dvq-pmxJ20qA-ymA@mail.gmail.com>
 <CAMsRxfJ2VrfFZevkxoZzSD5fZn1CErF68y0ny+MZi5r___ERJA@mail.gmail.com>
 <CACVXFVNixEUKmDf2iYtdJVThkYg3UeZEurbFhrod5NZhDyKRpw@mail.gmail.com>
 <CACVXFVNfc8fKe=6LVruj387-vQ85WHL7tAgZUT=9h6AQUM0X0Q@mail.gmail.com>
 <CAMsRxfLcO0eM8mkKUZcR8X6SG-MMRFasRK7hQCT-3-NuKN_+1g@mail.gmail.com>
 <CACVXFVPDdyKf5TffT4OMt+tKeB09TU2RcvcyBV45hAK0qw+GEg@mail.gmail.com>
 <CAMsRxfJK9kcFkV=itJHpzuOXoZQkmjj1wh8Y789D3iOVstPMyQ@mail.gmail.com>
 <CAMsRxfKPm0dEaKDeSZQ=6jkpo4MeS=0XF6TsCj+BV54WbW_LtA@mail.gmail.com>
 <CACVXFVMgk7ykSX3GjzCNvUU0zMzNvGGuZMBpxBf7NRVk9EM7ig@mail.gmail.com>
 <CAMsRxfJWjwznJYujSvr0DfhNxtnJDVdfjXXpx34HUDBRtMvjqw@mail.gmail.com>
 <20120127121311.GB2347@mudshark.cambridge.arm.com>
Message-ID: <CAMsRxfLN26dFsTpB49aEjK9Mhap7=pQjJbWk3+SzGwiK-ZGHYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 1:13 PM, Will Deacon <will.deacon@arm.com> wrote:
> Hi guys,
>
> On Sat, Jan 21, 2012 at 09:16:57AM +0000, stephane eranian wrote:
>> On Sat, Jan 21, 2012 at 4:25 AM, Ming Lei <ming.lei@canonical.com> wrote:
>> > On Fri, Jan 20, 2012 at 9:47 PM, stephane eranian
>> > <eranian@googlemail.com> wrote:
>> >> Started afresh from:
>> >>
>> >> 90a4c0f uml: fix compile for x86-64
>> >>
>> >> And added 3, 4, 5, 6:
>> >> 603c316 arm: omap4: pmu: support runtime pm
>> >> 4899fbd arm: omap4: support pmu
>> >> d737bb1 arm: omap4: create pmu device via hwmod
>> >> 4e0259e arm: omap4: hwmod: introduce emu hwmod
>> >>
>> >> Still no interrupts firing. I am using your .config file.
>> >>
>> >> My HW:
>> >> CPU implementer : 0x41
>> >> CPU architecture: 7
>> >> CPU variant ? ? : 0x1
>> >> CPU part ? ? ? ?: 0xc09
>> >> CPU revision ? ?: 2
>> >>
>> >> Hardware ? ? ? ?: OMAP4 Panda board
>> >> Revision ? ? ? ?: 0020
>> >>
>> >> There must be something I am missing here.
>
> Did this lead anywhere in the end? It seems as though Ming Lei has a working
> setup but Stephane is unable to replicate it, despite applying the necessary
> patches and trying an updated bootloader.
>
> Drastic suggestion: Stephane, could you try a kernel *binary* from Ming Lei?
> If that works then you're probably just missing a patch. If it doesn't, then
> there must be something different between your boards.
>
Sure, send me the binary+initrd and I can try it out.

> Will
