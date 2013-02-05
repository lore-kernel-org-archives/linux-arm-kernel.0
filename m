From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Tue, 5 Feb 2013 09:27:24 -0800
Subject: [GIT PULL] ARM part of USB patches
In-Reply-To: <51112495.4060908@ti.com>
References: <51112418.5020000@ti.com>
 <51112495.4060908@ti.com>
Message-ID: <20130205172724.GA1601@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 05, 2013 at 08:56:13PM +0530, kishon wrote:
> Hi Tony, Greg,
> 
> On Tuesday 05 February 2013 08:54 PM, kishon wrote:
> >Hi Tony,
> >
> >As discussed, I'm sending a pull request for the arch/arm part of my USB
> >patches. These patches are necessary to get MUSB functional in both dt
> >and non-dt boot. Also added dt data for dwc3 present in OMAP. This patch
> >series *depends* on some of the patches which are merged in usb-next.
> 
> This patch series should go in only after USB. Or else it will break
> compilation.

Then it probably should go through the USB tree, right?  We don't want
to break bisectability.

thanks,

greg k-h
