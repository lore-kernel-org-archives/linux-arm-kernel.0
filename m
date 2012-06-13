From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 12 Jun 2012 22:31:26 -0300
Subject: mx51evk kernel dump on next-20120612
In-Reply-To: <CAOMZO5ARiGCVWgVeY-xzKcxPkXJjL-fYZEAmq=k=3gaT=_HDoA@mail.gmail.com>
References: <CAOMZO5ARiGCVWgVeY-xzKcxPkXJjL-fYZEAmq=k=3gaT=_HDoA@mail.gmail.com>
Message-ID: <CAOMZO5CV3PNWcsg9QCeYB+rFFasfsiF9XY=BmGhp7cFKWVNM8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2012 at 9:41 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi,
>
> On a mx51evk running 3.5.0-rc2-next-20120612 I am getting:
>
> pinctrl core: initialized pinctrl subsystem
> ------------[ cut here ]------------
> WARNING: at include/linux/regmap.h:391 regulator_register+0xf8c/0x1128()
> regmap API is disabled

Ok, selecting the mx13892 mfd and regulator driver "fixes" it.

I will send a patch for imx_v6_v7_defconfig soon.

Regards,

Fabio Estevam
