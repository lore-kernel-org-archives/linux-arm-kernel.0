From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 7 Dec 2016 16:12:29 +0100
Subject: [PATCH v3 4/6] mfd: dt: Add bindings for the Aspeed LPC Host
 Controller (LHC)
In-Reply-To: <20161206025321.1792-5-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
 <20161206025321.1792-5-andrew@aj.id.au>
Message-ID: <CACRpkdYhKYjmaXf31Q44Wjvw=Bfjt=fViXH=SjaoDC6Kggotfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 6, 2016 at 3:53 AM, Andrew Jeffery <andrew@aj.id.au> wrote:

> The LPC bus pinmux configuration on fifth generation Aspeed SoCs depends
> on bits in both the System Control Unit and the LPC Host Controller.
>
> The Aspeed LPC Host Controller is described as a child node of the
> LPC host-range syscon device for arbitration of access by the host
> controller and pinmux drivers.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
