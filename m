From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Sep 2017 11:39:58 -0500
Subject: [PATCH 1/2] drm: bridge: Add bindings for TI THS8134
In-Reply-To: <20170901094038.4312-1-linus.walleij@linaro.org>
References: <20170901094038.4312-1-linus.walleij@linaro.org>
Message-ID: <20170912163958.xr5qxt5doqlk44dp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 01, 2017 at 11:40:37AM +0200, Linus Walleij wrote:
> This adds device tree bindings for the Texas Instruments
> THS8134A and THS8134B VGA DACs by extending and renaming the
> existing bindings for THS8135.
> 
> These DACs are used for the VGA outputs on the ARM reference
> designs such as Integrator, Versatile and RealView.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../display/bridge/{ti,ths8135.txt => ti,ths813x.txt}        | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>  rename Documentation/devicetree/bindings/display/bridge/{ti,ths8135.txt => ti,ths813x.txt} (73%)

Acked-by: Rob Herring <robh@kernel.org>
