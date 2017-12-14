From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 14 Dec 2017 11:22:57 +0800
Subject: [PATCH v4 03/15] dt-bindings: display: sun4i-drm: Add LVDS
 properties
In-Reply-To: <8b7042f5e85cc868ea802deba79a0c53ffbe6564.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
 <8b7042f5e85cc868ea802deba79a0c53ffbe6564.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66ZJwDr3zVwiRteDQtcHYRa5wU5dFDv600CP3grAr3v-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 7, 2017 at 11:58 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Some clocks and resets supposed to drive the LVDS logic in the display
> engine have been overlooked when the driver was first introduced.
>
> Add those additional resources to the binding, and we'll deal with the ABI
> stability in the code.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
