From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 2 Nov 2018 10:34:58 +0100
Subject: [PATCH V4 03/10] dt-bindings: gpio: vf610: add optional clocks
 property
In-Reply-To: <1541149669-10857-4-git-send-email-aisheng.dong@nxp.com>
References: <1541149669-10857-1-git-send-email-aisheng.dong@nxp.com>
 <1541149669-10857-4-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdbATLMRHdn+NGcNapLgozgvrKL+tAPhG4-=-P1=a9zZyQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 2, 2018 at 10:12 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

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
> ---
> v2->v3:
>  * no changes

Applied this already. (A bit of asynch here :)

Linus Walleij
