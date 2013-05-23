From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 23 May 2013 15:00:35 -0300
Subject: [PATCH 0/3] staging: fix parallel display regressions
In-Reply-To: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
References: <1368782393-9660-1-git-send-email-list-09_linuc_arm@tqsc.de>
Message-ID: <CAOMZO5AP24qMimaiOZoTJo0f2TJo3362kBHAH8jUmXdo0QVmhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Markus,

On Fri, May 17, 2013 at 6:19 AM, Markus Niebel
<list-09_linuc_arm@tqsc.de> wrote:
> From: Markus Niebel <Markus.Niebel@tqs.de>
>
> Support for VGA via TVE on iMX53 causes  regression, which prevents
> parallel display from working. This series brings the parallel display
> functionality back.
>
> Tested on a modified v3.9 with TQMa53 module and compile tested with
> v3.10-rc1.
>
> Markus Niebel (3):
>   staging: drm/imx: set correct sync pins for parallel display
>   staging: drm/imx: fix spelling error for vsync flag config
>   staging: drm/imx: revert vsync_cnt for di->id 1
>
>  drivers/staging/imx-drm/ipu-v3/ipu-di.c    |   13 +++++++++----
>  drivers/staging/imx-drm/parallel-display.c |    4 ++--
>  2 files changed, 11 insertions(+), 6 deletions(-)

Greg Kroah-Hartman <gregkh@linuxfoundation.org> is the one that takes
the patches for staging drivers.

Could you resend your series with him in Cc and add the Tested-by from
Philipp and Rogerio?

Thanks,

Fabio Estevam
