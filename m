From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 16:24:02 +0800
Subject: [PATCH v4 6/9] ARM: dts: add support for I2SE Duckbill 2 boards
In-Reply-To: <1486626169-20022-7-git-send-email-michael.heimpold@i2se.com>
References: <1486626169-20022-1-git-send-email-michael.heimpold@i2se.com>
 <1486626169-20022-7-git-send-email-michael.heimpold@i2se.com>
Message-ID: <20170410082400.GA1872@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 08:42:46AM +0100, Michael Heimpold wrote:
> From: Michael Heimpold <mhei@heimpold.de>
> 
> This machine is an USB pen drive sized development board,
> based on NXP's i.MX28 CPU. In contrast to the previous
> model "Duckbill", the "Duckbill 2" series has internal
> eMMC storage.
> 
> Signed-off-by: Michael Heimpold <mhei@heimpold.de>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  arch/arm/boot/dts/Makefile             |   1 +
>  arch/arm/boot/dts/imx28-duckbill-2.dts | 183 +++++++++++++++++++++++++++++++++
>  arch/arm/mach-mxs/mach-mxs.c           |   3 +-

I'm preparing pull request for 4.12 merge window, and found this.
C file change shouldn't be mixed in DTS patch, so I dropped it.  Please
submit C code change in a separate patch.

Shawn

>  3 files changed, 186 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/imx28-duckbill-2.dts
