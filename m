From: festevam@gmail.com (Fabio Estevam)
Date: Sun, 7 Feb 2016 13:19:55 -0200
Subject: [PATCH 1/1 v2] imx6q-wandboard-revb1.dts: use unique machine name
In-Reply-To: <1454760419-4822-1-git-send-email-xypron.glpk@gmx.de>
References: <1454758226-4561-1-git-send-email-xypron.glpk@gmx.de>
 <1454760419-4822-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <CAOMZO5CuCqWbZakc3POzPTYVOb_7zZ3VO807W+Q1M1fhtzUpYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 6, 2016 at 10:06 AM, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> Downstream packages like Debian flash-kernel use
> /proc/device-tree/model
> to determine which dtb file to install.
>
> Hence each dts in the Linux kernel should provide a unique model identifier.
>
> https://lkml.org/lkml/2014/7/8/579 created the new file
> imx6q-wandboard-revb1.dts but used the same model identifier
> as in imx6q-wandboard.dts.
>
> This patch provides a unique model identifier for revision B1 of
> the Wandboard Quad.
>
> v2:
>         correct name of referenced Debian package
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
