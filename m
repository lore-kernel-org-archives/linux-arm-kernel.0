From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 16 Feb 2013 10:12:00 -0500
Subject: [PATCH v2 1/4] arm: mvebu: Add support for SPI controller in
 Armada 370/XP
In-Reply-To: <1360155984-15397-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1360155984-15397-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1360155984-15397-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20130216151200.GS14746@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 06, 2013 at 10:06:21AM -0300, Ezequiel Garcia wrote:
> The Armada 370 and Armada XP SoC has an SPI controller.
> This patch adds support for this controller in Armada 370
> and Armada XP SoC common device tree files.
> 
> Note that the Armada XP SPI register length is 0x50 bytes,
> while Armada 370 SPI register length is 0x28 bytes,
> so we choose the smaller of the two.
> 
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Lior Amsalem <alior@marvell.com>
> Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v1:
>  * Register offset must be 0x28 instead of 0x50,
>    as pointed out by Gregory
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)

Applied to mvebu/dt, resolved an add/add (i2c, mvsdio, usb) conflict.

thx,

Jason.
