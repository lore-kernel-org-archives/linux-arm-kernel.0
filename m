From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 May 2015 22:30:48 +0200
Subject: [PATCH v4 4/7] ARM: dts: Add base DT for NXP LPC18xx
In-Reply-To: <1431381653-25356-5-git-send-email-manabian@gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-5-git-send-email-manabian@gmail.com>
Message-ID: <3308240.GYIY1gTjZ3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 May 2015 00:00:50 Joachim Eastwood wrote:
> NXP LPC18xx/43xx SoCs are very similar devices and should be able to
> share a common base (lpc18xx.dtsi). Diffences between the devices are
> put in a dtsi which is specific to that device.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> ---
>  arch/arm/boot/dts/lpc18xx.dtsi | 114 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>  create mode 100644 arch/arm/boot/dts/lpc18xx.dtsi

Applied patches 4 though 7 to next/dt, thanks!

	Arnd
