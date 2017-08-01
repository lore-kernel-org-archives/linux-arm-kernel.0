From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 1 Aug 2017 14:01:05 +0200
Subject: [PATCH RESEND 1/2] dt-bindings: gpio-vf610: add imx7ulp support
In-Reply-To: <1500990438-3894-2-git-send-email-aisheng.dong@nxp.com>
References: <1500990438-3894-1-git-send-email-aisheng.dong@nxp.com>
 <1500990438-3894-2-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CACRpkdbc6X7HNdJ3FJN7n6P1Uf3_006EjCDSaJ9Ekua-m_2eow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 3:47 PM, Dong Aisheng <aisheng.dong@nxp.com> wrote:

> The Rapid General-Purpose Input and Output with 2 Ports (RGPIO2P)
> on MX7ULP is similar to GPIO on Vibrid, except it has an extra
> Port Data Direction Register (PDDR) used to configure the individual
> port pins for input or output.
>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Alexandre Courbot <gnurou@gmail.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Stefan Agner <stefan@agner.ch>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Uncontroversial compatible update so patch applied.

Yours,
Linus Walleij
