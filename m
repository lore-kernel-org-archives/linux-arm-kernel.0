From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 23 Jan 2012 10:15:22 +0200
Subject: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP block
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
References: <20120121071934.18707.64258.stgit@dusk>
Message-ID: <1327306522.1916.11.camel@deskari>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-01-21 at 00:27 -0700, Paul Walmsley wrote:
> [ This series is targeted for merging during v3.3-rc ]
> 
> On v3.3-rc1, the OMAP serial console doesn't behave properly when
> power management is enabled (the default with omap2plus_defconfig).
> This seems to be due to a combination of a silicon bug in the UART IP
> block and broken FIFO settings in the OMAP serial driver.
> 
> This patch series attempts to work around these problems.  The workarounds
> are not perfect; see the patch descriptions for more details.
> 
> Tested on OMAP3530 BeagleBoard.  This series will need to be tested on
> OMAP2 and OMAP4 before it is ready to merge.

Thanks, this makes the console usable on my OMAP3 overo.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120123/8301390e/attachment.sig>
