From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Nov 2018 10:26:57 +0100
Subject: [PATCH V3 03/10] dt-bindings: gpio: vf610: add optional clocks
 property
In-Reply-To: <1540996688-23681-4-git-send-email-aisheng.dong@nxp.com>
References: <1540996688-23681-1-git-send-email-aisheng.dong@nxp.com>
 <1540996688-23681-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdZS_VEh-wzPm+fptrqStaDmP=fNcW0=Fk8r+Y+4Pd94nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 31, 2018 at 3:43 PM A.s. Dong <aisheng.dong@nxp.com> wrote:

> On some SoCs(e.g. MX7ULP), GPIO clock is gatable and maybe
> disabled by default. Users have to make sure it's enabled before
> being able to access controller registers, otherwise an external
> abort error may occur. Let's add the optional clocks property to
> handle this case.
>
> For ULP GPIO clock, it includes two separate clocks: one is for
> GPIO controller Input/Output function clock while another is
> GPIO port control clock for interrupt function.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: linux-gpio at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Patch applied.

Yours,
Linus Walleij
