From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 Sep 2012 17:58:32 +0100
Subject: [RFC 0/3] Initial stab at converting OMAP ASoC support to DMA engine
Message-ID: <20120903165832.GA31511@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following series of three patches is an attempt to convert the OMAP
ASoC backend to use the DMA engine support.

I'll bring your attention to the comments in patch 3 which highlight
some of the features lost in this process.  Some questions need
answering there (in particular the one concerning pause/resume)
especially as it seems the present driver could well be buggy wrt
comments recently on the mailing list about ALSA pause/resume
requirements.

This works for me, given the wind is in the right direction and if
it's sunny outside.  I find the audio support on OMAP to be rather
flakey at best, requiring reboots if it doesn't work first time.
