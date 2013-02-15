From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 15 Feb 2013 16:28:54 -0500
Subject: [PATCH v2 2/3] arm: mvebu: Enable USB controllers on Armada
 370/XP boards
In-Reply-To: <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1358954792-16160-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1358954792-16160-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130215212854.GF14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 23, 2013 at 12:26:31PM -0300, Ezequiel Garcia wrote:
> This patch activates every USB port provided by each SoC.
> Except for Armada XP Openblocks AX3-4 board,
> where we enable only the first two USB ports
> until we have more information on the third one usage.
> 
> Cc: Lior Amsalem <alior@marvell.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Tested-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Tested-by: Florian Fainelli <florian@openwrt.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v1:
>  * Squashed separate per-board patches into this one,
>    as suggested by Arnd.
>  * Remove usb at d0052000 activation in OpenBlocks AX3-4
>    until we have more information about it.
> 
>  arch/arm/boot/dts/armada-370-db.dts              |    8 ++++++++
>  arch/arm/boot/dts/armada-370-mirabox.dts         |    8 ++++++++
>  arch/arm/boot/dts/armada-xp-db.dts               |   12 ++++++++++++
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |    6 ++++++
>  4 files changed, 34 insertions(+), 0 deletions(-)

Applied to mvebu/dt

thx,

Jason.
