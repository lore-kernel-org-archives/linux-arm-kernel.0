From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 15 Jul 2013 15:27:01 -0300
Subject: [PATCH 18/22] staging: video: imx: Add RGB666 support for
 parallel display
In-Reply-To: <1373900227-341-19-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-19-git-send-email-denis@eukrea.com>
Message-ID: <CAOMZO5B8CuBR8sjVkDZH6ObLGKUUT1+jHPBujmFAQVGNtA5mBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Denis,

On Mon, Jul 15, 2013 at 11:57 AM, Denis Carikli <denis@eukrea.com> wrote:
> Support the RGB666 format on the IPUv3 parallel display.
>
> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/staging/imx-drm/fsl-imx-drm.txt       |    2 +-
>  drivers/staging/imx-drm/ipu-v3/ipu-dc.c            |    9 +++++++++
>  drivers/staging/imx-drm/parallel-display.c         |    2 ++
>  3 files changed, 12 insertions(+), 1 deletion(-)

Maybe you could split your series and send all the driver related
patches to their appropriate mailing lists and maintainers.
