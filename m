From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 8 Jun 2012 17:24:23 -0300
Subject: [GIT PULL] i.MX fixes
In-Reply-To: <CAOesGMhh68fWWpMfqBg2gyzWOo8x+_rbQkc-hzP-PRcu8jZA3A@mail.gmail.com>
References: <20120607200451.GQ30400@pengutronix.de>
 <CAOesGMhh68fWWpMfqBg2gyzWOo8x+_rbQkc-hzP-PRcu8jZA3A@mail.gmail.com>
Message-ID: <CAOMZO5B0LvFX2yhWZiBP34FT-Na5xxtVemMtZdMwQQXKHunFHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2012 at 5:23 AM, Olof Johansson <olof@lixom.net> wrote:
>
> Also, have you noticed that imx_v4_v5_defconfig has a build failure in
> mx2_camera.c?
>
> drivers/media/video/mx2_camera.c: In function 'mx2_camera_set_bus_param':
> drivers/media/video/mx2_camera.c:1032:42: error: 'pixfmt' undeclared
> (first use in this function)
> drivers/media/video/mx2_camera.c:1032:42: note: each undeclared
> identifier is reported only once for each function it appears in
ux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

This has already been addressed by the following patch:
http://patchwork.linuxtv.org/patch/11504/
