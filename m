From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 17 May 2013 12:56:56 -0400
Subject: [PATCH 2/2] ARM: mvebu: Add support for NOR flash device on
 Armada XP-DB board
In-Reply-To: <1368788998-4672-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1368788998-4672-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1368788998-4672-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130517165656.GE11137@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 17, 2013 at 08:09:58AM -0300, Ezequiel Garcia wrote:
> The Armada XP Development Board (DB-78460-BP) has a NOR flash device
> connected to the Device Bus. This commit adds the device tree node
> to support this device.
> 
> This SoC supports a flexible and dynamic decoding window allocation
> scheme; but since this feature is still not implemented we need
> to specify the window base address in the device tree node itself.
> 
> This base address has been selected in a completely arbitrary fashion.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-db.dts | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
