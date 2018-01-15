From: davem@davemloft.net (David Miller)
Date: Mon, 15 Jan 2018 14:40:23 -0500 (EST)
Subject: [PATCH net-next 1/2 v11] net: ethernet: Add DT bindings for
 the Gemini ethernet
In-Reply-To: <20180112213424.16442-1-linus.walleij@linaro.org>
References: <20180112213424.16442-1-linus.walleij@linaro.org>
Message-ID: <20180115.144023.747027495666540365.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 12 Jan 2018 22:34:23 +0100

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
