From: mike.looijmans@topic.nl (Mike Looijmans)
Date: Mon, 29 Aug 2016 09:02:28 +0200
Subject: FPGA manager: What is the proper way to load a bitstream now?
Message-ID: <57C3DE04.4030109@topic.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "FPGA manager" has been around for a while now, so I thought to integrate 
it. However, there's apparently only a kernel-to-kernel interface and it isn't 
actually being used in current mainline kernels?

So far, I've been using vendor provided drivers to load the FPGA bitstream 
(e.g. "cat fpga.bin > /dev/xdevcfg") somewhere early during boot.

With the FPGA manager, while looking for a userspace interface, all I found 
were proposals to do so, that have been 'shot down', even the nice ones using 
DT overlays, and in the end, there is apparently no way whatsover to simply 
load a bitstream at boot, other that writing (yet another) driver to trigger 
the firmware load at some stage.

Is this an accurate summary of the current state, or is there something I've 
missed?

(resent because of corporate mailserver turning plaintext into HTML)
