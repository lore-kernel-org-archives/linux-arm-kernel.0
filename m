From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 10:20:16 -0500
Subject: [PATCH 1/2] arm: mvebu: Add SPI flash on Armada XP-DB board
In-Reply-To: <1360097695-32663-2-git-send-email-gregory.clement@free-electrons.com>
References: <1360097695-32663-1-git-send-email-gregory.clement@free-electrons.com>
 <1360097695-32663-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130216152016.GU14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 09:54:54PM +0100, Gregory CLEMENT wrote:
> This patch add support for the SPI flash M25P64 which is present on
> the Armada XP DB board. This flash stores the bootloader and its
> environment.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-xp-db.dts |   12 ++++++++++++
>  1 file changed, 12 insertions(+)

Both 1 and 2 of this series applied to mvebu/dt, resolved add/add
conflicts in both (usb).

thx,

Jason.
