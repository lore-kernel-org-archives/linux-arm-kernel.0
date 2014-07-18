From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 18 Jul 2014 11:51:21 +0200
Subject: [PATCH] ARM: zynq: dt: Add GPIO node
In-Reply-To: <1405018418-23396-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1405018418-23396-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <f27926ad-5c25-405a-a461-6d7ec7be628b@BL2FFO11FD054.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2014 08:53 PM, Soren Brinkmann wrote:
> Add node describing Zynq's GPIO controller.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> The GPIO driver and binding documentation is staged in Linus' GPIO tree.
> 
> 	S?ren
> 
>  arch/arm/boot/dts/zynq-7000.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Applied for zynq dt-next when gpio driver is in mainline.

Thanks,
Michal
