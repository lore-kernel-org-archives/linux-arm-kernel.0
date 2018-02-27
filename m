From: horms@verge.net.au (Simon Horman)
Date: Tue, 27 Feb 2018 09:09:10 +0100
Subject: [PATCH 0/2] arm64: dts: r8a77965: salvator-x(s): Enable s2ram
 and PMIC
In-Reply-To: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
References: <1519659743-27027-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20180227080910.oevdck7upggudxks@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 04:42:21PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch populates the placeholders in the R-Car M3-N DTS file for the
> IIC Bus Interface for DVFS (IIC for DVFS) and Interrupt Controller for
> External Devices (INTC-EX) device nodes.
> 
> After applying the first patch, you can start using s2ram (PSCI
> suspend), like on other Salvator-X(S) boards
> (https://elinux.org/R-Car/Boards/Salvator-XS#PSCI_System_Suspend).
> 
> The second patch enables dependencies for the BD9571MWV PMIC device,
> which is described in salvator-common.dtsi. Note that operation still
> depends on "[PATCH] pinctrl: sh-pfc: r8a77965: Add support for INTC-EX
> IRQ pins".
> 
> Thanks!

Thanks, applied.
