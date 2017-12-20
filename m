From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 Dec 2017 22:25:11 +0100
Subject: [PATCH v4 0/4] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
References: <20171218115133.16371-1-linux-kernel-dev@beckhoff.com>
Message-ID: <20171220212511.GC15162@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/2017 at 12:51:29 +0100, linux-kernel-dev at beckhoff.com wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> 
> Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.
> 
> This is driver enables support for the low power domain SRTC features:
> - 32-bit MSB of non-rollover time counter
> - 32-bit alarm register
> 
> Select the new config option RTC_DRV_MXC_V2 to build this driver
> 
> Based on:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01
> 
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> 

Applied 1/4 and 3/4, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
