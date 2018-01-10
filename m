From: davem@davemloft.net (David Miller)
Date: Wed, 10 Jan 2018 15:40:47 -0500 (EST)
Subject: [PATCH net-next 1/2 v10] net: ethernet: Add DT bindings for
 the Gemini ethernet
In-Reply-To: <20180109221053.927-1-linus.walleij@linaro.org>
References: <20180109221053.927-1-linus.walleij@linaro.org>
Message-ID: <20180110.154047.2155726732823195708.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue,  9 Jan 2018 23:10:52 +0100

> This adds the device tree bindings for the Gemini ethernet
> controller. It is pretty straight-forward, using standard
> bindings and modelling the two child ports as child devices
> under the parent ethernet controller device.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Tobias Waldvogel <tobias.waldvogel@gmail.com>
> Cc: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Applied.
