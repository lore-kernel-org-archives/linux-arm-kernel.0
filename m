From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 11 Apr 2013 13:33:34 -0400
Subject: [PATCH v7 2/5] ARM: mvebu: Add Device Bus support for Armada
 370/XP SoC
In-Reply-To: <1365620644-15790-3-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1365620644-15790-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1365620644-15790-3-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130411173334.GL28693@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 04:04:01PM -0300, Ezequiel Garcia wrote:
> Armada 370 and Armada XP SoC have a Device Bus controller to
> handle NOR, NAND, SRAM and FPGA devices.
> This patch adds the device tree node to enable the controller.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 45 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Patches 2 through 5 applied to mvebu/dt

thx,

Jason.
