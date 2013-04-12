From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 13 Apr 2013 00:24:18 +0200
Subject: [PATCH 3/3] pinctrl: add MVF pinctrl driver
In-Reply-To: <1365753432-14247-1-git-send-email-b35083@freescale.com>
References: <1365753432-14247-1-git-send-email-b35083@freescale.com>
Message-ID: <CACRpkdZMnFT4FUFsErRUKnbFW=sOif3n8rRL0zKChXSHj3RAbg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 12, 2013 at 9:57 AM, Jingchang Lu <b35083@freescale.com> wrote:

> It adds Freescale Vybrid Family pin controller
> driver to I.MX IOMUXC common driver architecture.
> The only difference is the MUX and CONF register
> is the same on MVF platform, so the defined
> config value including the mux_mode int DTS.
>
> Signed-off-by: Jingchang Lu <b35083@freescale.com>

Looks OK as such drivers goes, but can I have an ACK from
some of the Freescale maintainers?

Yours,
Linus Walleij
