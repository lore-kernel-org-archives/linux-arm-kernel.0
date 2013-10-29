From: timur@tabi.org (Timur Tabi)
Date: Tue, 29 Oct 2013 07:42:41 -0500
Subject: [PATCH 2/3] ASoC: fsl_ssi: Add dual fifo mode support
In-Reply-To: <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
References: <cover.1383047327.git.b42378@freescale.com>
 <02f8867363ed3038a0a70703856e4b642fef4339.1383047327.git.b42378@freescale.com>
Message-ID: <526FAD41.2000805@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolin Chen wrote:
> By enabling dual fifo mode, it would allow SSI enter a better performance
> to transimit/receive data without occasional hardware underrun/overrun.

Have you measured any real performance gain with this patch?  I 
considered adding dual-FIFO support when I originally wrote this driver, 
but it didn't appear to have any real benefit, but it used twice as many 
DMA channels.

I'm concerned that this is another patch that just enables a useless 
feature.
