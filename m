From: greg@kroah.com (Greg KH)
Date: Wed, 23 Jul 2014 23:42:18 -0700
Subject: linux-next: manual merge of the usb tree with the arm-soc tree
In-Reply-To: <20140724163329.03002387@canb.auug.org.au>
References: <20140724162811.5e12107a@canb.auug.org.au>
 <20140724163329.03002387@canb.auug.org.au>
Message-ID: <20140724064218.GB22398@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 04:33:29PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Thu, 24 Jul 2014 16:28:11 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the usb tree got a conflict in
> > drivers/phy/Kconfig between commit 64562e99477f ("phy: Add drivers for
> > PCIe and SATA phy on SPEAr13xx") from the arm-soc tree and commit
> > 1de990d8a169 ("phy: qcom: Add driver for QCOM APQ8064 SATA PHY") from
> > the usb tree.
> > 
> > I fixed it up (see below) and can carry the fix as necessary (no action
> > is required).
> 
> Also drivers/phy/Makefile

Both look good, thanks.

greg k-h
