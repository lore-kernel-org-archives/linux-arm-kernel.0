From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 18 Dec 2013 09:08:12 -0200
Subject: [PATCH V3 1/2] ARM: imx: add vddsoc/pu setpoint info into dts
In-Reply-To: <1387402010-31749-1-git-send-email-b20788@freescale.com>
References: <1387402010-31749-1-git-send-email-b20788@freescale.com>
Message-ID: <CAOMZO5DCGOkUtWmEok-uEFsUpGLF+93Vhm9XFs02yH9Z+eV0uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, Dec 18, 2013 at 7:26 PM, Anson Huang <b20788@freescale.com> wrote:

> +  Documentation/devicetree/bindings/regulator/regulator.txt for details.
> +  arm-supply: vddarm input.
> +  pu-supply: vddpu input.
> +  soc-supply: vddsoc input.

I found these messages confusing, as someone may think that you are
referring to the VDD_ARM_IN/VDD_ARM23_IN and VDD_SOC_IN, which are
really inputs.

What about doing this instead?

arm-supply: VDDARM LDO output
pu-supply:  VDDPU LDO output
soc-supply: VDDSOC LDO output

Regards,

Fabio Estevam
