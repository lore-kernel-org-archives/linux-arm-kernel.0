From: will.deacon@arm.com (Will Deacon)
Date: Mon, 6 Feb 2017 10:06:08 +0000
Subject: [PATCH RESEND 1/3] arm64: add THUNDER2 processor family
In-Reply-To: <1486233461-2679-2-git-send-email-jnair@caviumnetworks.com>
References: <1486233461-2679-1-git-send-email-jnair@caviumnetworks.com>
 <1486233461-2679-2-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170206100608.GA8540@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 04, 2017 at 06:37:39PM +0000, Jayachandran C wrote:
> Add support for ThunderX2 CN99XX arm64 server processors.
> 
> Introduce a new arm64 platform config option ARCH_THUNDER2 for these
> processors. Add device tree files boot/dts/cavium/thunder-99xx.dtsi for
> on-chip devices and boot/dts/cavium/thunder-99xx.dts for the evaluation
> board.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  arch/arm64/Kconfig.platforms                 |   7 ++
>  arch/arm64/boot/dts/cavium/Makefile          |   1 +
>  arch/arm64/boot/dts/cavium/thunder-99xx.dts  |  34 +++++++
>  arch/arm64/boot/dts/cavium/thunder-99xx.dtsi | 147 +++++++++++++++++++++++++++

This is basically identical to vulcan.dtsi. Do we really need both in the
tree?

Will
