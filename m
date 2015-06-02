From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 2 Jun 2015 11:47:45 +0200
Subject: [PATCH v3 0/3] ARM: berlin: BG2Q SPI support
In-Reply-To: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1433237869-3762-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20150602094745.GA2165@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 02, 2015 at 11:37:46AM +0200, Antoine Tenart wrote:
> Hi,
> 
> This series adds the SPI nodes for the Berlin BG2Q SoC as well as
> comments on the Berlin spi pinctrl functions.
> 
> Antoine

Oops, forgot to summarize the changes...

Changes since v2:
	- renamed spi nodes
	- added comments after the pinctrl SPI function definitions

Changes since v1:
	- reworked the pinmux
	- removed useless interrupt-parent properties
	- typo

> 
> Antoine Tenart (3):
>   pinctrl: berlin: fix spi1 SS0n function name
>   pinctrl: berlin: comment the spi functions
>   ARM: berlin: add SPI nodes for BG2Q
> 
>  arch/arm/boot/dts/berlin2q.dtsi       | 36 +++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/berlin/berlin-bg2.c   | 18 +++++++++---------
>  drivers/pinctrl/berlin/berlin-bg2cd.c |  8 ++++----
>  drivers/pinctrl/berlin/berlin-bg2q.c  | 16 ++++++++--------
>  4 files changed, 57 insertions(+), 21 deletions(-)
> 
> -- 
> 2.4.2
> 

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
