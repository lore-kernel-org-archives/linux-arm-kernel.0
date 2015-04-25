From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 25 Apr 2015 11:28:30 +0200 (CEST)
Subject: [PATCHv2 1/2] ARM: dts: imx23: Add i2c support
In-Reply-To: <1429281806-7934-1-git-send-email-harald@ccbib.org>
References: <1429281806-7934-1-git-send-email-harald@ccbib.org>
Message-ID: <629731861.499409.1429954110131.JavaMail.open-xchange@oxbaltgw08.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Harald,

[add Marek and Wolfram]

> Harald Geyer <harald@ccbib.org> hat am 17. April 2015 um 16:43 geschrieben:
>
>
> The imx23-olinuxino board has an i2c interface exposed on UEXT connector.
> This patch provides the generic devicetree infrastructure for a follow-up
> patch to add support to the actual board files.
> Tested all three possible pin groups with MOD-LCD1x9 from Olimex.
>
> This patch is based on work by Fadil Berisha with his permission. However
> all bugs are mine.
>
> Signed-off-by: Harald Geyer <harald@ccbib.org>
> ---
> changes since v1:
> split in generic and board specific patches
> arch/arm/boot/dts/imx23.dtsi | 40 +++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 39 insertions(+), 1 deletion(-)
>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
