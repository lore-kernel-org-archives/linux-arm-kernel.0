From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 26 Jul 2018 16:38:10 -0500
Subject: [PATCH 00/14] arm64: dts: meson-axg: add audio support
In-Reply-To: <CAFBinCB_fULnmrpyzNwnfAiL9QGco_6QW957Wroj8o6ZhNwmWA@mail.gmail.com>
 (Martin Blumenstingl's message of "Wed, 25 Jul 2018 23:26:27 +0200")
References: <20180724125238.14567-1-jbrunet@baylibre.com>
 <CAFBinCBh-b=ie4hBMWdHG8KoLQ7qiRfo8vXfJ1PRcN4UPtg+uA@mail.gmail.com>
 <705e31bf0d978b7d356b2f077179ab0e3db6f092.camel@baylibre.com>
 <CAFBinCB_fULnmrpyzNwnfAiL9QGco_6QW957Wroj8o6ZhNwmWA@mail.gmail.com>
Message-ID: <7hfu051xvh.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> Hi Jerome,
>
> On Wed, Jul 25, 2018 at 11:19 PM <jbrunet@baylibre.com> wrote:
>>
>> On Wed, 2018-07-25 at 21:11 +0200, Martin Blumenstingl wrote:
>> > nit-pick: one patch uses "arm64: dts: meson-axg: s400" in the subject
>> > while other patches that are touching the s400 board aren't
>> > if you have to re-send this series: can you please use the "arm64:
>> > dts: meson-axg: s400:" prefix for all patches touching the s400 board?
>>
>> hum, do we really have such rule, or do you think we should add one ?
> looking at the git history in arch/arm64/boot/dts/amlogic: it seems
> that we don't have a rule yet, even though some (some of
> your's/Neil's/my) patches were using that naming schema in the past
>
>> Kevin, do you have opinion ?
>>
>> Not that I really mind either way, but prefixes rules are usually there to help
>> maintainer filter the patches. Will such rule help in any way ?
> maybe it's just a problem of a false initial impression
> I read "arm64: dts: meson-axg: add usb power regulator" in the
> cover-letter and came to the conclusion that this patch must be wrong
> since meson-axg.dtsi should not have any regulators (unless they're
> built into the SoC). only when looking at the patch itself I realized
> that it's fine because it patches the s400.dts

I actually had the same first impression problem.  At first glance, it
looks like all the patches are AXG-generic, and only the 2 that mention
s400 apply to the board.

So, if this needs a respin, I'd prefer the board name where appropriate,
but it's not something I'm going to be picky about.

Kevin
