From: robh@kernel.org (Rob Herring)
Date: Wed, 24 Oct 2018 16:55:43 -0500
Subject: [PATCH V2 3/8] dt-bindings: gpio: vf610: add optional clocks
 property
In-Reply-To: <1540295058-26090-4-git-send-email-aisheng.dong@nxp.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20181024215543.GA26387@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Oct 2018 11:49:13 +0000, "A.s. Dong" wrote:
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
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: linux-gpio at vger.kernel.org
> Cc: devicetree at vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
> v1->v2:
>  * new patch
> ---
>  Documentation/devicetree/bindings/gpio/gpio-vf610.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
