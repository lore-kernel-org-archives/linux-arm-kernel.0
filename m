From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Mar 2014 12:35:45 +0100
Subject: [PATCH v3 2/2] ARM: zynq: dt: Add I2C nodes to Zynq device tree
In-Reply-To: <1394556613-11692-2-git-send-email-soren.brinkmann@xilinx.com>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
 <1394556613-11692-2-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <ff9e2fa6-5202-4b2a-967c-a9cb14463276@CH1EHSMHS003.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 05:50 PM, Soren Brinkmann wrote:
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v3:
>  - no changes
> v2:
>  - replace 'pmbus' with 'ti' in compatibility strings of UCD devices
> ---
>  arch/arm/boot/dts/zynq-7000.dtsi | 22 ++++++++++++
>  arch/arm/boot/dts/zynq-zc702.dts | 76 ++++++++++++++++++++++++++++++++++++++++
>  arch/arm/boot/dts/zynq-zc706.dts | 68 +++++++++++++++++++++++++++++++++++
>  3 files changed, 166 insertions(+)

Rob, Mark: Any problem with binding?

Thanks,
Michal
