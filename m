From: robh@kernel.org (Rob Herring)
Date: Fri, 15 Dec 2017 15:43:48 -0600
Subject: [PATCH net-next 1/2 v8] net: ethernet: Add DT bindings for the
 Gemini ethernet
In-Reply-To: <20171210224558.27122-1-linus.walleij@linaro.org>
References: <20171210224558.27122-1-linus.walleij@linaro.org>
Message-ID: <20171215214348.bp6geu53vs6a5riw@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 10, 2017 at 11:45:57PM +0100, Linus Walleij wrote:
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
> ChangeLog v7->v8:
> - Use ethernet-port at 0 and ethernet-port at 1 with unit names
>   and following OF graph requirements.
> ---
>  .../bindings/net/cortina,gemini-ethernet.txt       | 92 ++++++++++++++++++++++
>  1 file changed, 92 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt

Reviewed-by: Rob Herring <robh@kernel.org>
