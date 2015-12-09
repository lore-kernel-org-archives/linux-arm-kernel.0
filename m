From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 9 Dec 2015 11:25:56 -0200
Subject: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: assert GPIO at boot
 in order to connect NOR
In-Reply-To: <1449618520-3432-2-git-send-email-alison_chaiken@mentor.com>
References: <20151207082440.GY11966@pengutronix.de>
 <1449618520-3432-1-git-send-email-alison_chaiken@mentor.com>
 <1449618520-3432-2-git-send-email-alison_chaiken@mentor.com>
Message-ID: <CAOMZO5CLcA9Ws4sTMBcjS+mvKw6dU7HR-nNpLahtY9AyA=sLwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 8, 2015 at 9:48 PM, Alison Chaiken
<alison_chaiken@mentor.com> wrote:

> +&gpio5 {
> +       p4 {
> +               /* Select NOR or I2C3 via setting of port-expander
> +                * steering logic.
> +                * Low: Attach p-NOR line D18.
> +                * High: Attach I2C3 line SDA.
> +                */
> +               gpio-initval;

Markus' series that add gpio-initval property has not been applied
yet. I could not see it in linux-next.

It seems you need his series to be applied first.
