From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 14 Nov 2018 23:27:56 +0800
Subject: [PATCH v2 1/4] dt-bindings: media: sun6i: Add A31 and H3
 compatibles
In-Reply-To: <20181114145934.26855-2-maxime.ripard@bootlin.com>
References: <20181114145934.26855-1-maxime.ripard@bootlin.com>
 <20181114145934.26855-2-maxime.ripard@bootlin.com>
Message-ID: <CAGb2v64yR+XOk9upmQCOcEpZptMiFepVQsiggoW2B_n8z6s5vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 14, 2018 at 10:59 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> The H3 has a slightly different CSI controller (no BT656, no CCI) which
> looks a lot like the original A31 controller. Add a compatible for the A31,
> and more specific compatible the for the H3 to be used in combination for
> the A31.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
