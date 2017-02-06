From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 6 Feb 2017 15:30:11 +0800
Subject: [PATCH 9/9] ARM: sun5i: gr8: Use common sun5i DTSI
In-Reply-To: <f9e1a964b48561cb52b68cad690d35ea793c95d0.1486320544.git-series.maxime.ripard@free-electrons.com>
References: <cover.8519ab0b2252458a322bea5955d191e63f67100b.1486320544.git-series.maxime.ripard@free-electrons.com>
 <f9e1a964b48561cb52b68cad690d35ea793c95d0.1486320544.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v644NjJGEhQhvML2KOHBChpGMPzDAzdZS8xF2u0C83egag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 6, 2017 at 2:49 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Most of the GR8 DTSI is duplicated with the common sun5i DTSI, and some of
> the extra nodes defined there actually apply to all of the sun5i family.
>
> Move those into the common DTSI so that all SoCs can benefit from it, and
> include the sun5i DTSI.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

I think it's possible to move the display-engine node over as well?

Acked-by: Chen-Yu Tsai <wens@csie.org>
