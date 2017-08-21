From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 14:21:38 -0500
Subject: [PATCH 1/4 v2] drm/tve200: Add DT bindings
In-Reply-To: <20170820100557.24991-1-linus.walleij@linaro.org>
References: <20170820100557.24991-1-linus.walleij@linaro.org>
Message-ID: <CAL_JsqKeVT5ODav+Mca0oHb0euJVUgU5UGgvsYXyPZj_DPqFsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 20, 2017 at 5:05 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> This adds device tree bindings for the Faraday TVE200 IP block.
> This IP block is present in the Gemini ARM SoC and also in some
> Grain Media GMxxxx SoCs.
>
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix display port bindings: list required endpoint.
> - Fix the example to include an endpoint.
> ---
>  .../devicetree/bindings/display/faraday,tve200.txt | 54 ++++++++++++++++++++++
>  1 file changed, 54 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt

Acked-by: Rob Herring <robh@kernel.org>
