From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Mon, 4 Dec 2017 19:06:53 +0100 (CET)
Subject: [PATCH net-next 1/2 v6] net: ethernet: Add DT bindings for the
 Gemini ethernet
In-Reply-To: <20171202110640.5284-1-linus.walleij@linaro.org>
References: <20171202110640.5284-1-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1712041905170.9142@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

On Sat, 2 Dec 2017, Linus Walleij wrote:

> This adds the device tree bindings for the Gemini ethernet
> controller. It is pretty straight-forward, using standard
> bindings and modelling the two child ports as child devices
> under the parent ethernet controller device.
> 
> Cc: devicetree at vger.kernel.org
> Cc: Tobias Waldvogel <tobias.waldvogel@gmail.com>
> Cc: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/cortina,gemini-ethernet.txt       | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
>

Acked-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
