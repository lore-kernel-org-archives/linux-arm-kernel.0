From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 May 2013 10:25:31 +0800
Subject: [PATCH 1/2] ARM: dts: imx: Remove custom dma-channel bindings
In-Reply-To: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
References: <1368713639-21485-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20130517022529.GA8607@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 11:13:58AM -0300, Fabio Estevam wrote:
> Commit f30fb03 (ARM: dts: add generic DMA device tree binding for mxs-dma) added
> the generic DMA dt bindings, but missed to remove the old ones.
> 
> Remove the the old dma bindings.

I already had a patch [1] to remove those old DMA binding data (both
channel and interrupt number) from client device nodes.  And I'm waiting
for mxs-saif/pcm to be converted to generic DMA binding helper to apply
the patch.  Mark has queued mxs-saif conversion for 3.11, and I have to
wait for 3.11-rc1 to apply the dts cleanup.

Shawn

[1] http://thread.gmane.org/gmane.linux.alsa.devel/106027/focus=220815
