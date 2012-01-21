From: greg@kroah.com (Greg KH)
Date: Sat, 21 Jan 2012 07:55:22 -0500
Subject: [PATCH 0/2] tty: serial: OMAP: work around broken driver, IP block
In-Reply-To: <20120121071934.18707.64258.stgit@dusk>
References: <20120121071934.18707.64258.stgit@dusk>
Message-ID: <20120121125522.GA19027@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 21, 2012 at 12:27:37AM -0700, Paul Walmsley wrote:
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

Who is going to do that testing?  When?  Why isn't it done already?

I guess this means I can ignore them for now, right?

greg k-h
