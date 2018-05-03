From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 3 May 2018 19:14:10 +0200
Subject: [PATCH v9 0/2] Initial Allwinner V3s CSI Support
In-Reply-To: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
References: <1520301070-48769-1-git-send-email-yong.deng@magewell.com>
Message-ID: <20180503171410.q52ak27u47gycy6o@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Mar 06, 2018 at 09:51:10AM +0800, Yong Deng wrote:
> This patchset add initial support for Allwinner V3s CSI.
> 
> Allwinner V3s SoC features two CSI module. CSI0 is used for MIPI CSI-2
> interface and CSI1 is used for parallel interface. This is not
> documented in datasheet but by test and guess.
> 
> This patchset implement a v4l2 framework driver and add a binding 
> documentation for it. 
> 
> Currently, the driver only support the parallel interface. And has been
> tested with a BT1120 signal which generating from FPGA. The following
> fetures are not support with this patchset:
>   - ISP 
>   - MIPI-CSI2
>   - Master clock for camera sensor
>   - Power regulator for the front end IC

Do you plan on sending another version some time soon? It would be
awesome to have this in 4.18.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
