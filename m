From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 23 Jan 2017 13:24:36 +0800
Subject: [PATCH] ARM: dts: imx6q-utilite-pro: enable 2nd display pipeline
In-Reply-To: <ec9676f344eb4786a28a3c7b969f0e94@rwthex-s1-b.rwth-ad.de>
References: <ec9676f344eb4786a28a3c7b969f0e94@rwthex-s1-b.rwth-ad.de>
Message-ID: <20170123052434.GC5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 02, 2016 at 03:37:22PM +0100, christopher.spinrath at rwth-aachen.de wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> 
> Apart from the already enabled Designware HDMI port, the Utilite Pro
> has a second display pipeline which has the following shape:
> 
>   IPU1 DI0 --> Parallel display --> tfp410 rgb24 to DVI encoder
>                                 --> HDMI connector.
> Enable support for it.
> 
> In addition, since this pipeline is hardwired to IPU1, sever the link
> between IPU1 and the SoC-internal Designware HDMI encoder forcing the
> latter to be connected to IPU2 instead of IPU1. Otherwise, it is not
> possible to drive both displays at high resolution due to the bandwidth
> limitations of a single IPU.
> 
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>

Applied, thanks.
