From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 6 Nov 2012 11:40:42 +0100
Subject: [PATCH 0/7] ARM: AM33XX: net: Add DT support to CPGMAC and
 MDIO driver
In-Reply-To: <1352189545-26303-1-git-send-email-mugunthanvnm@ti.com>
References: <1352189545-26303-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20121106104042.GA10955@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 01:42:18PM +0530, Mugunthan V N wrote:
> This patch-series adds support for,
> 
> [1/7]: Typo mistake in CPSW driver while invoking runtime_pm api's
> 
> [2/7]: Adds parent<->child relation between CPSW & MDIO module inside cpsw
>        driver, as in case of AM33XX, the resources are shared and common
>        register bit-field is provided to control module/clock enable/disable,
>        makes it difficult to handle common resource.
> 
>        So the solution here is, to create parent<->child relation between them.
> 
> [3/7]: Add hwmod entry for MDIO module, required for MDIO driver.
> 
> [4/7]: cpsw: simplify the setup of the register pointers
> 
> [5/7]: Add DT device nodes for both CPSW and MDIO modules in am33xx.dtsi,
>        am335x-evm.dts and am335x-bone.dts file
> 
> [6/7]: Enable CPSW support to omap2plus_defconfig
> 
> [7/7]: cpsw: Kernel warn fix during suspend

Acked-by: Richard Cochran <richardcochran@gmail.com>
