From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Apr 2017 23:33:06 +0200
Subject: [PATCH v11 2/3] drm/panel: Add support for S6E3HA2 panel driver
 on TM2 board
In-Reply-To: <1488937357-5623-3-git-send-email-hoegeun.kwon@samsung.com>
References: <1488937357-5623-1-git-send-email-hoegeun.kwon@samsung.com>
 <CGME20170308014258epcas5p3eb623c49b888c91ef102a7fc8f35d1b7@epcas5p3.samsung.com>
 <1488937357-5623-3-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <20170406213306.GC27728@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 08, 2017 at 10:42:36AM +0900, Hoegeun Kwon wrote:
> This patch add support for MIPI-DSI based S6E3HA2 AMOLED panel
> driver. This panel has 1440x2560 resolution in 5.7-inch physical
> panel in the TM2 device.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Hyungwon Hwang <human.hwang@samsung.com>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/gpu/drm/panel/Kconfig                 |   6 +
>  drivers/gpu/drm/panel/Makefile                |   1 +
>  drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c | 739 ++++++++++++++++++++++++++
>  3 files changed, 746 insertions(+)
>  create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e3ha2.c

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170406/c6fc703d/attachment.sig>
