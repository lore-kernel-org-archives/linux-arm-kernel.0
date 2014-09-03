From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 03 Sep 2014 23:01:15 +0200
Subject: [PATCH v4 01/12] reset: add the Berlin reset controller driver
In-Reply-To: <1409730511-16101-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1409730511-16101-1-git-send-email-antoine.tenart@free-electrons.com>
 <1409730511-16101-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5407819B.2060605@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 09:48 AM, Antoine Tenart wrote:
> Add a reset controller for Marvell Berlin SoCs which is used by the
> USB PHYs drivers (for now).
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  drivers/reset/Makefile       |   1 +
>  drivers/reset/reset-berlin.c | 131 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 drivers/reset/reset-berlin.c

I guess the reset stuff is quite independent from usb-phy and can
be picked up now.

Applied
01/12 and 03/12 to berlin/soc and
02/12 and 04/12 to berlin/dt.

Thanks!

For the usb-phy dts patches, I'll wait for the corresponding genphy
patches.

Sebastian
