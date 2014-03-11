From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 12:02:59 +0000
Subject: [PATCH v9 0/9] USB Host support for OMAP5 uEVM
In-Reply-To: <531ECDCB.4060700@ti.com>
References: <1393510711-4697-1-git-send-email-rogerq@ti.com>
 <531ECDCB.4060700@ti.com>
Message-ID: <20140311120259.GI21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > Hi,
> > 
> > This patchset brings up USB Host ports and Ethernet port on
> > the OMAP5 uEVM board.
> > 
> > It also does some cleanup with respect to DT clock binding
> > for the mfd/omap-usb-host driver.
> > 
> > Please queue these for -next.
> > 
> > Lee,
> > 
> > I've folded some platform data dependent patches with mfd patches
> > so that they don't break functionality when applied individually.
> > You can safely pull in all MFD patches (1 to 6).
> > 
> > Tony & Benoit,
> > 
> > Can you please accept patches 7, 8 and 9?
> 
> Tony has already picked up 7,8 and 9 through omap-soc tree.
> 
> Since you acked most patches except 5 and 6, are you fine if Tony takes
> all the patches 1 to 4 in this series via omap-soc tree?
> 
> What about patches 5 and 6?

Any patches which are orthogonal can just be sucked into whichever tree
they belong in. If there are inter-subsystem dependencies I'd prefer
to take them and issue a immutable branch pull-request to the other
maintainers.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
