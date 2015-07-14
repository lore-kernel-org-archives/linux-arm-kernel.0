From: olof@lixom.net (Olof Johansson)
Date: Tue, 14 Jul 2015 11:21:17 +0200
Subject: [PATCH 0/4] ARM: digicolor: misc updates for 4.3
In-Reply-To: <cover.1436182214.git.baruch@tkos.co.il>
References: <cover.1436182214.git.baruch@tkos.co.il>
Message-ID: <20150714092117.GE20686@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 02:41:42PM +0300, Baruch Siach wrote:
> This series contains the following updates for Conexant Digicolor machines:
> 
>    * Enable the watchdog driver that was added during the 4.2 merge window, 
>      both in .dtsi and in multi_v7_defconfig
> 
>    * Use the standard stdout-path property in the chosen node to configure the 
>      console
> 
>    * Make .dts/.dtsi files to the Digicolor MAINTAINERS entry
> 
> Based on v4.2-rc1.
> 
> Baruch Siach (4):
>   ARM: digicolor: enable watchdog device
>   ARM: multi_v7_defconfig: enable Conexant Digicolor watchdog
>   ARM: digicolor: dts: use stdout-path for console configuration
>   MAINTAINERS: digicolor: add dts files

Thanks, I applied the two DT patches to next/dt, the defconfig change to next/defconfig.


-Olof
