From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 26 Sep 2017 21:01:24 +0800
Subject: [PATCH v3 00/14] ARM: dts: sunxi: Fix DT build warnings
In-Reply-To: <20170926085855.7yn6zdx3sfuwwxyj@flea>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
 <CAGb2v64AK-xifjcowUk1mp4TRwHFPOqjZR58Bd5w7Bei52T06g@mail.gmail.com>
 <20170926085855.7yn6zdx3sfuwwxyj@flea>
Message-ID: <CAGb2v67=VyHd3n1PgT-2_2efUNijOM8TkwDO9oAQvUd8wYH-qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 4:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Sep 26, 2017 at 07:48:17AM +0000, Chen-Yu Tsai wrote:
>> On Tue, Sep 26, 2017 at 3:22 PM, Corentin Labbe
>> <clabbe.montjoie@gmail.com> wrote:
>> > Hello
>> >
>> > The goal of this patch series is to have a clean DT build with W=1.
>> >
>> > Regards
>> >
>> > Changes since v1:
>> > - moved i2c2 unit address change from patch #2 in patch #1
>> >
>> > Changes since v2
>> > - added two patch for fixing pin names
>>
>> The first twelve patches are good. Maxime, I think we can go ahead and
>> merge them, instead of having them resent again in v3?
>
> Yep, that works for me. Can you push them?

Patches 1 and 12 didn't apply cleanly. I fixed them.

Patches 4~9 do the same type of cleanup for various h3 board dts files.
Maybe we should just squash them together. Arnd seems to prefer squashing
identical changes to different boards together.


ChenYu
