From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jan 2016 11:20:31 -0200
Subject: [PATCH v3 1/2] ARM: dts: imx6: Add support for Toradex Apalis
 iMX6Q/D SoM
In-Reply-To: <1452909067-1998-2-git-send-email-marcel.ziswiler@toradex.com>
References: <1452909067-1998-1-git-send-email-marcel.ziswiler@toradex.com>
 <1452909067-1998-2-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <CAOMZO5ABVgiopLtO02vSkwc6hDe_nSSHGOkFHX5jVn42iohAyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 11:51 PM, Marcel Ziswiler
<marcel.ziswiler@toradex.com> wrote:

> +&ssi1 {
> +       fsl,mode = "i2s-slave";

This line should be removed.
