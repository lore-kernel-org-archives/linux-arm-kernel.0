From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Dec 2017 12:05:02 +0800
Subject: [PATCH 00/20] Add Hummingboard 2 support
In-Reply-To: <20171211165631.GW10595@n2100.armlinux.org.uk>
References: <20171211165631.GW10595@n2100.armlinux.org.uk>
Message-ID: <20171226040500.GC4210@X250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 04:56:31PM +0000, Russell King - ARM Linux wrote:
> Hi,
> 
> This series adds the long awaited Hummingboard 2 support to the
> mainline kernel.
> 
> While I could squash the patch set down, I've not done this because
> this is the result of several different people over the course of
> the last couple of years, and I believe it's not right to lose the
> detail of their contributions.
> 
> This builds upon the previous set of changes for the Hummingboard,
> which re-organised the way we deal with the uSOM and baseboards.
> 
>  arch/arm/boot/dts/Makefile                         |   6 +
>  .../boot/dts/imx6dl-hummingboard2-emmc-som-v15.dts |  55 +++
>  arch/arm/boot/dts/imx6dl-hummingboard2-som-v15.dts |  54 +++
>  arch/arm/boot/dts/imx6dl-hummingboard2.dts         |  53 ++
>  .../boot/dts/imx6q-hummingboard2-emmc-som-v15.dts  |  63 +++
>  arch/arm/boot/dts/imx6q-hummingboard2-som-v15.dts  |  62 +++
>  arch/arm/boot/dts/imx6q-hummingboard2.dts          |  61 +++
>  arch/arm/boot/dts/imx6qdl-hummingboard2-emmc.dtsi  |  72 +++
>  arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi       | 540 +++++++++++++++++++++
>  9 files changed, 966 insertions(+)

Applied all, thanks.
