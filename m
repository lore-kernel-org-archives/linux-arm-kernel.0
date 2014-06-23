From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 23 Jun 2014 13:46:40 -0500
Subject: [PATCH 0/2] ARM: socfpga: Update socfpga_defconfig and
 socfpga.dtsi
In-Reply-To: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
References: <1403483462-21082-1-git-send-email-vbridgers2013@gmail.com>
Message-ID: <1403549200.9081.1.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2014-06-22 at 19:31 -0500, Vince Bridgers wrote:
> This patch series updates the the socfpga_defconfig with a number of options,
> and updates the socfpga device tree with a field required for the reset
> controller driver. 
> 
> Vince Bridgers (2):
>   ARM: socfpga: Update socfpga_defconfig
>   ARM: socfpga: Add missing #reset-cells to socfpga device tree
> 
>  arch/arm/boot/dts/socfpga.dtsi     |    1 +
>  arch/arm/configs/socfpga_defconfig |   35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 

I've applied both patches to:

git.rocketboards.org/linux-socfpga-next.git for-next.

Thanks,
Dinh
