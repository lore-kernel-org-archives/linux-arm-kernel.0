From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:44:11 +0800
Subject: [PATCH 09/20] ARM: dts: sun4i: Remove SoC node unit-name to avoid
 warnings
In-Reply-To: <c9f2be09d1e5d69e728e246567b289a278a1cb54.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <c9f2be09d1e5d69e728e246567b289a278a1cb54.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65wbizeO3s3o2W=Cx9_4mqkPJcT=7GmbFUdY9_yfJP_QA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Our main node for all the in-SoC controllers used to have a unit name. The
> unit-name, in addition to being actually false, would not match any reg
> property, which generates a warning.
>
> Remove it in order to remove those warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
