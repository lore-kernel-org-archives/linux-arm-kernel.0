From: greg@kroah.com (Greg KH)
Date: Wed, 28 Nov 2012 21:17:30 -0800
Subject: linux-next: manual merge of the arm-soc tree with the
 driver-core tree
In-Reply-To: <20121129160309.7dc352f433d39f1bde0018a8@canb.auug.org.au>
References: <20121129160309.7dc352f433d39f1bde0018a8@canb.auug.org.au>
Message-ID: <20121129051730.GD4375@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 29, 2012 at 04:03:09PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the arm-soc tree got a conflict in
> drivers/leds/leds-ns2.c between commit 98ea1ea20cb7 ("leds: remove use of
> __devinit") from the driver-core tree and commit 72052fcc1026 ("leds:
> leds-ns2: add device tree binding") from the arm-soc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary (no action
> is required).

Looks good, thanks.

greg k-h
