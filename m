From: jun.nie@linaro.org (Jun Nie)
Date: Sat, 16 May 2015 15:05:11 +0800
Subject: [PATCH v4 4/7] ARM: dts: zx: add an initial zx296702 dts and doc
In-Reply-To: <15088943.GUMZUHMVfp@wuerfel>
References: <1430212691-16009-1-git-send-email-jun.nie@linaro.org>
 <1430212691-16009-5-git-send-email-jun.nie@linaro.org>
 <2168253.ZrhOUFeSpY@wuerfel> <15088943.GUMZUHMVfp@wuerfel>
Message-ID: <CABymUCOVumKXbV8MU3oKVBBrXJA_m8fsr8GGtWHZevQichCG-Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

B.R.
Jun


2015-05-16 4:19 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Friday 15 May 2015 21:59:06 Arnd Bergmann wrote:
>> On Tuesday 28 April 2015 17:18:08 Jun Nie wrote:
>> > Add initial dts file and document for ZX296702 and board ZX296702-AD1.
>> > More peripherals will be added later.
>> >
>> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
>>
>> Applied to next/dt, thanks!
>>
>>
>
> And removed again. I hadn't pushed it out to a public tree yet and
> found a build error in this.
>
> Unfortunately, you are using a header file here that is only introduced
> by a patch that belongs to another subsystem maintainer.
>
> Please try to get rid of that dependency, or submit this patch again
> for the following merge window once that driver has been merged upstream.
>
> In a lot of cases, you can just use hardware numbers as identifiers
> instead of making up your own, to avoid having to use ugly header files
> that make life hard for us.
>
>         Arnd

Hi Arnd,

I have to use macro in file
"include/dt-bindings/clock/zx296702-clock.h" for clock id. Because it
is hard to maintain the id as it is has nothing to do with hardware
and I may add more clock later. I will post patch 4/5/7 after the dts
patch merged. Thanks!

Jun
