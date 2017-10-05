From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:23:25 +0800
Subject: [PATCH 03/20] ARM: dts: sun4i: Change framebuffer node names to
 avoid warnings
In-Reply-To: <a7a00cff95247b2c240473a1a7bacb2bc49db9fd.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <a7a00cff95247b2c240473a1a7bacb2bc49db9fd.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65nB48Rb95P+mCX=2RzzsmKKJ_i5y3xroAke9qPNHZHEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The simple-framebuffer nodes have a unit address, but no reg property which
> generates a warning when compiling it with DTC.
>
> Change the simple-framebuffer node names so that there is no warnings on
> this anymore.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

Since this is only a couple changed lines per .dtsi, you might want to have
them all in one patch?

ChenYu
