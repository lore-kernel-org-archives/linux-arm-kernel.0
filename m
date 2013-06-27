From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 27 Jun 2013 15:13:32 +0200
Subject: [GIT PULL] DaVinci DT updates for v3.11
In-Reply-To: <51CB3828.6060407@ti.com>
References: <51CB3828.6060407@ti.com>
Message-ID: <201306271513.32395.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 26 June 2013, Sekhar Nori wrote:
> Device Tree updates for DaVinci
> 
> This patch set updates da850 DTS files to enable use of
> C pre-processor. Also updates pinctrl-single DT data
> to go with changes done in that module to enable a
> single register to service configuration of multiple
> pins.
> 
> ----------------------------------------------------------------
> Manjunathappa, Prakash (1):
>       ARM: davinci: da850: adopt to pinctrl-single change for configuring multiple pins
> 
> Philip Avinash (1):
>       ARM: davinci: da850: Use #include for all device trees
> 
>  arch/arm/boot/dts/da850-enbw-cmc.dts |    2 +-
>  arch/arm/boot/dts/da850-evm.dts      |    2 +-
>  arch/arm/boot/dts/da850.dtsi         |    4 ++--
>  3 files changed, 4 insertions(+), 4 deletions(-)

Looks simple enough, I've put it into next/late, thanks!

	Arnd
