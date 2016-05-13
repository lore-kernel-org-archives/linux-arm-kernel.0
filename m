From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 13 May 2016 13:04:12 +0200
Subject: imx-drm: regression due to commit 503fe87bd0a8 ("gpu: ipu-v3:
 Fix imx-ipuv3-crtc module autoloading")
In-Reply-To: <20160513123336.6996dd89@ipc1.ka-ro>
References: <20160513123336.6996dd89@ipc1.ka-ro>
Message-ID: <1463137452.3544.5.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lothar,

Am Freitag, den 13.05.2016, 12:33 +0200 schrieb Lothar Wa?mann:
> Hi,
> 
> the commit 503fe87bd0a8 ("gpu: ipu-v3: Fix imx-ipuv3-crtc module autoloading")
> indeed fixes the autoloading issue, but completely breaks the driver in
> non-modular mode (at least with the parallel-display driver I didn't
> yet check with the imx-ldb driver.
> Can anyone confirm that the imx-drm driver in current linux-next
> (next-20160512) works for them with any i.MX6 or i.MX53 board?

I have sent a patch: https://patchwork.kernel.org/patch/9081661/
that I'd appreciate your input on.

regards
Philipp
