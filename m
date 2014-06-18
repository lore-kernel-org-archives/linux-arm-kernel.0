From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Jun 2014 15:12:15 +0200
Subject: [PATCH] ARM: mvebu: enable Dove SoC in mvebu_v7_defconfig
In-Reply-To: <1403046536-18563-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1403046536-18563-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <4236992.O6ztruovPx@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 June 2014 20:08:56 Ezequiel Garcia wrote:
> Since commit:
> 
> commit d93003e8e4e1fbbc8a06ec561a63f5aa105a4c45
> Author: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Date:   Thu Apr 24 22:58:30 2014 +0100
> 
>     ARM: 8042/1: iwmmxt: allow to build iWMMXt on Marvell PJ4B
> 
> fixed the error that prevented Dove SoC from being built with
> the rest of the mvebu SoCs, we can now add it to the defconfig.
> 
> In addition, this commit enables SERIAL_OF_PLATFORM, which is required
> to have UART on some of the boards.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> 

Applied to fixes branch, thanks!

	Arnd
