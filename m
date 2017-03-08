From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 8 Mar 2017 11:39:38 +0800
Subject: [PATCH 6/15] dt-bindings: display: sun4i: Add HDMI display
 bindings
In-Reply-To: <f1d46b79f933df724a6750d557ebe9517b6339b5.1488876832.git-series.maxime.ripard@free-electrons.com>
References: <cover.bc06ffa88f847ddd9ddd7c259415d5f61b55307b.1488876832.git-series.maxime.ripard@free-electrons.com>
 <f1d46b79f933df724a6750d557ebe9517b6339b5.1488876832.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65eMyznxURoogO6+HBr+6eosXq4njRBFLAo4=CdhfOX0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 7, 2017 at 4:56 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> One of the possible output of the display pipeline, on the SoCs that have
> it, is the HDMI controller.
>
> Add a binding for it.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

TODO: A31 will also need a DDC clock.
