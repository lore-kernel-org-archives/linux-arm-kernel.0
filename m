From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Sat, 8 Nov 2014 09:18:51 +0000
Subject: [PATCH v3 06/10] [media] platform: Make use of media_bus_format
 enum
In-Reply-To: <1415369269-5064-7-git-send-email-boris.brezillon@free-electrons.com>
References: <1415369269-5064-1-git-send-email-boris.brezillon@free-electrons.com>
 <1415369269-5064-7-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CA+V-a8t79gYYGcgg5wvM-eqW8H2D6WD7xM9t2Px=WHb2rf34ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Thanks for the patch,

On Fri, Nov 7, 2014 at 2:07 PM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> In order to have subsytem agnostic media bus format definitions we've
> moved media bus definition to include/uapi/linux/media-bus-format.h and
> prefixed values with MEDIA_BUS_FMT instead of V4L2_MBUS_FMT.
>
> Reference new definitions in all platform drivers.
>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> ---
>  arch/arm/mach-davinci/board-dm355-evm.c            |   2 +-
>  arch/arm/mach-davinci/board-dm365-evm.c            |   4 +-
>  arch/arm/mach-davinci/dm355.c                      |   7 +-
>  arch/arm/mach-davinci/dm365.c                      |   7 +-

@Sekhar can you ack for the machine changes for davinci ?

[Snip]
>  drivers/media/platform/davinci/vpbe.c              |   2 +-
>  drivers/media/platform/davinci/vpfe_capture.c      |   4 +-
[snip]
>  include/media/davinci/vpbe.h                       |   2 +-
>  include/media/davinci/vpbe_venc.h                  |   5 +-

For all the above.

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Thanks,
--Prabhakar Lad
