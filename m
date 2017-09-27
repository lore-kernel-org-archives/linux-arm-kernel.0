From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 27 Sep 2017 23:18:09 +0800
Subject: [PATCH v3 00/14] ARM: dts: sunxi: Fix DT build warnings
In-Reply-To: <CAGb2v67=VyHd3n1PgT-2_2efUNijOM8TkwDO9oAQvUd8wYH-qg@mail.gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
 <CAGb2v64AK-xifjcowUk1mp4TRwHFPOqjZR58Bd5w7Bei52T06g@mail.gmail.com>
 <20170926085855.7yn6zdx3sfuwwxyj@flea>
 <CAGb2v67=VyHd3n1PgT-2_2efUNijOM8TkwDO9oAQvUd8wYH-qg@mail.gmail.com>
Message-ID: <CAGb2v67=Esq3mHkRhP6sBuzFtyDWjeON4Uwx93H5z2LMQ63eJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 26, 2017 at 9:01 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Tue, Sep 26, 2017 at 4:58 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> On Tue, Sep 26, 2017 at 07:48:17AM +0000, Chen-Yu Tsai wrote:
>>> On Tue, Sep 26, 2017 at 3:22 PM, Corentin Labbe
>>> <clabbe.montjoie@gmail.com> wrote:
>>> > Hello
>>> >
>>> > The goal of this patch series is to have a clean DT build with W=1.
>>> >
>>> > Regards
>>> >
>>> > Changes since v1:
>>> > - moved i2c2 unit address change from patch #2 in patch #1
>>> >
>>> > Changes since v2
>>> > - added two patch for fixing pin names
>>>
>>> The first twelve patches are good. Maxime, I think we can go ahead and
>>> merge them, instead of having them resent again in v3?
>>
>> Yep, that works for me. Can you push them?
>
> Patches 1 and 12 didn't apply cleanly. I fixed them.

Patch 10 didn't apply cleanly either. I fixed it.

> Patches 4~9 do the same type of cleanup for various h3 board dts files.
> Maybe we should just squash them together. Arnd seems to prefer squashing
> identical changes to different boards together.

Squashed them and mentioned it in the commit message.

Please check the sunxi tree on git.kernel.org if the results are correct.

ChenYu
