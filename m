From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 24 Oct 2015 11:30:32 +0800
Subject: [PATCH RESEND v6 0/2] ARM: sunxi: Add Reduced Serial Bus (RSB)
 controller support
In-Reply-To: <1445625691-20289-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1445625691-20289-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v66utAE-Pzmn7dNuWOCGV-Y_=U9sfhGh=Cey-J-Y9BNHpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, Olof,

On Sat, Oct 24, 2015 at 2:41 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Arnd, Kevin, Olof,
>
> As discussed on IRC, here is a resend of these RSB patches, to merge
> for 4.4.

Please merge them on a topic branch, so we can try to merge other
patches depending on them. If possible I'd like to get an actual
user in 4.4, otherwise this driver won't get any usage until the
next merge window.

I'll try to send out a new version of the AXP223 patches later today.

Thanks!

Regards
ChenYu

> The original cover letter was:
>
> This is v6 of the Allwinner Reduced Serial Bus driver. This version puts
> the driver under drivers/bus instead of drivers/soc/sunxi. There are no
> changes to the binding or the driver itself.
>
> The series is based on v4.3-rc1.
>
> Thanks!
> Maxime
>
> Chen-Yu Tsai (2):
>   bus: sunxi-rsb: Add Allwinner Reduced Serial Bus (RSB) controller
>     bindings
>   bus: sunxi-rsb: Add driver for Allwinner Reduced Serial Bus
>
>  .../devicetree/bindings/bus/sunxi-rsb.txt          |  47 ++
>  drivers/bus/Kconfig                                |  11 +
>  drivers/bus/Makefile                               |   1 +
>  drivers/bus/sunxi-rsb.c                            | 783 +++++++++++++++++++++
>  include/linux/sunxi-rsb.h                          | 105 +++
>  5 files changed, 947 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/sunxi-rsb.txt
>  create mode 100644 drivers/bus/sunxi-rsb.c
>  create mode 100644 include/linux/sunxi-rsb.h
>
> --
> 2.6.2
>
