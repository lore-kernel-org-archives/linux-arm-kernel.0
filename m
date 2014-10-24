From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 24 Oct 2014 14:23:34 +0200
Subject: [PATCH v5 4/4] Documentation: dts: add bindings for Vybrid
 GPIO/PORT module
In-Reply-To: <12bd7950696ad30aa05348270df2e024ba113e63.1413488264.git.stefan@agner.ch>
References: <cover.1413488264.git.stefan@agner.ch>
 <12bd7950696ad30aa05348270df2e024ba113e63.1413488264.git.stefan@agner.ch>
Message-ID: <CACRpkdZwtexz_85CPfhMWXj0=Xmo=7kuOh8BA9H8zBGdmshwEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 9:48 PM, Stefan Agner <stefan@agner.ch> wrote:

> The Vybrid SoC device tree (vf610.dtsi) used this bindings since
> its initial commit in May 2013. However, a proper gpiolib driver
> was missing so far. With the addition of the gpiolib driver,
> the bindings proved to be useful and complete, hence a good time
> to add the documentation.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> Acked-by: Shawn Guo <shawn.guo@freescale.com>

Patch applied to the GPIO tree.

Yours,
Linus Walleij
