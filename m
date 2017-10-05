From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:24:28 +0800
Subject: [PATCH 03/20] ARM: dts: sun4i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <CAGb2v65nB48Rb95P+mCX=2RzzsmKKJ_i5y3xroAke9qPNHZHEQ@mail.gmail.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <a7a00cff95247b2c240473a1a7bacb2bc49db9fd.1507198895.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65nB48Rb95P+mCX=2RzzsmKKJ_i5y3xroAke9qPNHZHEQ@mail.gmail.com>
Message-ID: <CAGb2v66eAykcZ2RP8821Bb_oDL=dWH3PzpapBWSSsG0hqLOe2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 11:23 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> The simple-framebuffer nodes have a unit address, but no reg property which
>> generates a warning when compiling it with DTC.
>>
>> Change the simple-framebuffer node names so that there is no warnings on
>> this anymore.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
> Since this is only a couple changed lines per .dtsi, you might want to have
> them all in one patch?

Never mind. I forgot you were only doing sun4i and sun9i right now.

ChenYu
