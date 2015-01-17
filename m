From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Sat, 17 Jan 2015 22:27:48 +0100
Subject: [PATCH 1/3] USB: host: ehci_atmel: Move global variables to
 private struct
In-Reply-To: <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
References: <1421519013-22123-1-git-send-email-sylvain.rochet@finsecur.com>
 <Pine.LNX.4.44L0.1501171524050.13485-100000@netrider.rowland.org>
Message-ID: <20150117212748.GA21783@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alan,

On Sat, Jan 17, 2015 at 03:30:45PM -0500, Alan Stern wrote:
> 
> This is not the right way to do it.  For an example of the right way, 
> see the ehci-platform.c file.  Your private structure is stored in 
> ehci->priv, and its size is specified by the .extra_priv_size member of 
> an ehci_driver_overrides structure passed to ehci_init_driver().

Dammit? reworked this way, thanks for the heads-up !

Sylvain
