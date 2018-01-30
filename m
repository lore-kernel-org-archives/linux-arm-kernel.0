From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 30 Jan 2018 23:15:35 +0100
Subject: [PATCH 3/4] ARM: dts: at91: nattis: use the correct compatible
 for the eeprom
In-Reply-To: <20180116160618.27859-4-peda@axentia.se>
References: <20180116160618.27859-1-peda@axentia.se>
 <20180116160618.27859-4-peda@axentia.se>
Message-ID: <20180130221535.GL2809@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/01/2018 at 17:06:17 +0100, Peter Rosin wrote:
> The used part does contain an eeprom compatible with an Atmel 24c02
> chip and it is from NXP, but it is not called 24c02. It's actually a
> se97b chip. Adjust the compatible accordingly.
> 
> Fixes: 0e4323899973 ("ARM: dts: at91: add devicetree for the Axentia Nattis with Natte power")
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  arch/arm/boot/dts/at91-nattis-2-natte-2.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
