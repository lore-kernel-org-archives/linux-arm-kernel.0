From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Oct 2017 23:53:07 +0800
Subject: [PATCH 16/20] ARM: dts: sun9i: Remove GPIO pinctrl nodes to avoid
 warnings
In-Reply-To: <349ac0811adc34fb98bd66cbe6ee9cdd720236de.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
 <349ac0811adc34fb98bd66cbe6ee9cdd720236de.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65-Ec4w_Omj3myXJv412Pzsi1+9_GPugvP_61+tbTkokA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 5, 2017 at 6:49 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The A80 boards still define some GPIO pinctrl nodes that are not really
> useful, and redundant with the muxing already happening on gpio_request.
>
> Let's remove those nodes. This will also remove DTC warnings.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
