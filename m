From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 Dec 2011 14:01:09 -0200
Subject: [RFC PATCH v2 2/4] pinctrl: imx: add pinmux imx driver
In-Reply-To: <1323878622-26602-3-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-3-git-send-email-b29396@freescale.com>
Message-ID: <CAOMZO5DVsk_iNCrMaBbK4kuehhL1C71fKqC65isybJDknzWrRQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 2:03 PM, Dong Aisheng <b29396@freescale.com> wrote:

> +config PINMUX_IMX53
> + ? ? ? bool "IMX53 pinmux driver"
> + ? ? ? depends on ARCH_MX5

Shouldn't this be SOC_IMX53 instead?

Regards,

Fabio Estevam
