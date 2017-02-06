From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:11:13 +0800
Subject: [PATCH 2/9] ARM: sun5i: a10s: switch simple framebuffer indices
In-Reply-To: <5f1f3913705fecab150e11be06b4e560fe2865e2.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <5f1f3913705fecab150e11be06b4e560fe2865e2.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v64u181ZANGtJNEOj8YomkgSVeZtC66=YjrF5YKk6iUPwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Of the three simple framebuffer setups we have in the A10s, two of them can
> be shared with the other SoCs from the sun5i family (LCD panel and
> composite output).
>
> However, the only one we cannot share is the HDMI, which is the first
> listed in the A10s DTSI. In order to make it more logical and so that we
> can share the framebuffer nodes in the common DTSI, reorder those nodes.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
