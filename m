From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 24 May 2015 10:48:37 +0800
Subject: [PATCH v2] imx: thermal: use CPU temperature grade info for
 thresholds
In-Reply-To: <1432251947-13335-1-git-send-email-tharvey@gateworks.com>
References: <1430409757-16195-1-git-send-email-tharvey@gateworks.com>
 <1432251947-13335-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20150524024836.GA3264@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 21, 2015 at 04:45:47PM -0700, Tim Harvey wrote:
> The IMX6Q/IMX6DL SoC's have a 2-bit temperature grade stored in OTP which
> is valid for all IMX6 SoC's (despite the fact that the IMXSDLRM and
> IMXSXRM do not document this - this has been proven via tests as well as
> verified by Freescale FAE).
> 
> Instead of assuming a fixed 85C for passive cooling threshold and 105C for
> critical use the thermal grade for these configurations.
> 
> We will set the critical to maxT - 5C and passive to maxT - 10C.
> 
> Cc: Anson Huang <b20788@freescale.com>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
