From: greg@kroah.com (Greg KH)
Date: Tue, 18 Jun 2013 09:03:12 -0700
Subject: linux-next: manual merge of the arm-soc tree with the usb tree
In-Reply-To: <20130618161239.5ce92432180d9418831d2514@canb.auug.org.au>
References: <20130618161239.5ce92432180d9418831d2514@canb.auug.org.au>
Message-ID: <20130618160312.GB28961@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 04:12:39PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/usb/phy/phy-rcar-usb.c between commit 56a9a6de2a87 ("usb: phy:
> rcar-usb: Fix comment w.r.t. devm_ioremap_resource") from the usb tree
> and commit 725bf9dcafe1 ("phy-rcar-usb: correct base address") from the
> arm-soc tree.
> 
> I fixed it up (The latter removed the comment corrected by the former)
> and can carry the fix as necessary (no action is required).

That sounds fine to me, thanks.

greg k-h
