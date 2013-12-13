From: marex@denx.de (Marek Vasut)
Date: Fri, 13 Dec 2013 12:54:25 +0100
Subject: [PATCH V1 09/11] ARM: dts: imx6qdl-sabrelite: fix ENET group
In-Reply-To: <1386899355-17379-10-git-send-email-troy.kisky@boundarydevices.com>
References: <1386899355-17379-1-git-send-email-troy.kisky@boundarydevices.com>
 <1386899355-17379-10-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <201312131254.25217.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, December 13, 2013 at 02:49:13 AM, Troy Kisky wrote:
> GPIO16 is used for I2C3, not ENET_REF_CLK.
> Replace MX6QDL_ENET_PINGRP1 with explicit list.
> Also, remove pull-ups from tx pins.

Reviewed-by: Marek Vasut <marex@denx.de>

Best regards,
Marek Vasut
