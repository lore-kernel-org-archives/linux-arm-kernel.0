From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 24 Nov 2013 12:16:48 -0500
Subject: [PATCHv2] ARM: mvebu: Add RN104 SATA LEDs driven via NXP
 PCA9554 I2C to GPIO muxer
In-Reply-To: <87mwkx4ayr.fsf@natisbad.org>
References: <87mwkx4ayr.fsf@natisbad.org>
Message-ID: <20131124171648.GL29241@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 22, 2013 at 12:00:12AM +0100, Arnaud Ebalard wrote:
> 
> NETGEAR ReadyNAS 104 has a NXP PCA9554 I2C to GPIO chip. Among the 8 GPIO
> lines the chip makes available, four are used on the device to control
> the SATA LEDs (the four remaining ones are used for SATA disk presence).
> This patch adds DT entries for NXP PCA9554 and the four SATA GPIO LEDs.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> 
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts | 32 ++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)

Applied to mvebu/dt

thx,

Jason.
