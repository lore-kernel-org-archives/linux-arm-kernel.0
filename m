From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 10 Apr 2018 10:01:12 -0300
Subject: A200 driver submission for Linux mainline kernel
In-Reply-To: <01f5f95e-d957-bc32-b8a8-94784523d095@gmail.com>
References: <01f5f95e-d957-bc32-b8a8-94784523d095@gmail.com>
Message-ID: <CAOMZO5C0pnPgeJ7MLX_f+1qZjJ6FF=ap6ytdm-OoCMsvcw_mEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhijit,

On Tue, Apr 10, 2018 at 4:58 AM, abhijit <abhijitnaik27@gmail.com> wrote:
> Hi All,
>
> I have tested A200/Z430 3D driver for Freescale IMX535/537 SoC by using port
> from freedreno. I wanted to submit driver patch to linux 4.14.1 for
> mainlining A200 driver support
>
> Currently w.r.t 4.14.1 kernel, the patch has, 109 files changes, 279170
> insertions, 60 deletions
>
> Major part of the code is taken from A200 support from Freescale Linux
> (2.6.35,
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/?h=imx_2.6.35)
>
> My question was, can I submit the patch for Linux 4.14.1 kernel for
> mainlining purpose instead of linux-next?

As you are adding a new feature, it is better to base your work
against linux-next or against 4.17-rc1 when it becomes available.

> Please point me to any case-study where such huge enhancements were
> mainlined in the past.

You can take a look at:

commit a8c21a5451d831e67b7a6fb910f9ca8bc7b43554
Author: The etnaviv authors <dri-devel@lists.freedesktop.org>
Date:   Thu Dec 3 18:21:29 2015 +0100

    drm/etnaviv: add initial etnaviv DRM driver

    This adds the etnaviv DRM driver and hooks it up in Makefiles
    and Kconfig.

    Signed-off-by: Christian Gmeiner <christian.gmeiner@gmail.com>
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
    Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
    Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Regards,

Fabio Estevam
