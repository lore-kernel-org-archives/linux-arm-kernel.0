From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Mar 2014 12:34:23 +0100
Subject: [PATCH v3 1/2] i2c: Add driver for Cadence I2C controller
In-Reply-To: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1394556613-11692-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <96ea5cd7-0873-4352-b835-5c5a0dbad685@TX2EHSMHS037.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/11/2014 05:50 PM, Soren Brinkmann wrote:
> Add a driver for the Cadence I2C controller. This controller is for
> example found in Xilinx Zynq.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v3:
>  - incorporate signal handling changes from Mike Looijmans
>    <mike.looijmans@topic.nl> (https://lkml.org/lkml/2014/3/11/64)
> v2:
>  - make driver depend on COMMON_CLK instead of ARCH_ZYNQ
> ---
>  .../devicetree/bindings/i2c/i2c-cadence.txt        |  21 +
>  MAINTAINERS                                        |   1 +
>  drivers/i2c/busses/Kconfig                         |   7 +
>  drivers/i2c/busses/Makefile                        |   1 +
>  drivers/i2c/busses/i2c-cadence.c                   | 898 +++++++++++++++++++++
>  5 files changed, 928 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt
>  create mode 100644 drivers/i2c/busses/i2c-cadence.c

For boot test on zynq zc702 3.14.0-rc6.
Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
