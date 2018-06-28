From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 28 Jun 2018 10:33:04 -0300
Subject: [PATCH 2/2] ARM: dts: imx51-babbage: Make use of pinctrl_usbh1reg
In-Reply-To: <20180628043713.14425-2-andrew.smirnov@gmail.com>
References: <20180628043713.14425-1-andrew.smirnov@gmail.com>
 <20180628043713.14425-2-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5A_fpyf+qEBhbQRW2nEATb+sAXcLfkQeptNWk7V8ezZrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2018 at 1:37 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Pinctrl_usbh1reg defines pinmux setting for reset GPIO used by
> usbh1phy, but is not referenced by that node. Fix that.
>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
