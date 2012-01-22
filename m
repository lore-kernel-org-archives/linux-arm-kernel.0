From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 Jan 2012 21:07:40 +0100
Subject: [PATCH 3/3] ARM: OMAP: I2C: fix compilation when !CONFIG_OF
In-Reply-To: <alpine.DEB.2.00.1201221250510.26641@utopia.booyaka.com>
References: <20120122105942.6508.82335.stgit@dusk>
 <20120122110232.6508.68451.stgit@dusk>
 <20120122154544.GW4223@ponder.secretlab.ca>
 <4F1C3412.4070106@gmail.com> <4F1C406A.6040503@ti.com>
 <alpine.DEB.2.00.1201221250510.26641@utopia.booyaka.com>
Message-ID: <20120122210740.735d8ca5@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 22 Jan 2012 12:54:21 -0700 (MST), Paul Walmsley wrote:
> cc Ben, Jean

I'm not involved in this at all.

Jean

> 
> On Sun, 22 Jan 2012, Cousson, Benoit wrote:
> 
> > http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-December/010541.html
> > 
> > But it looks like it was stuck in linux-omap dt branch and not pulled for 3.3.
> > Maybe Tony can try to sent it during -rc phase.
> > 
> > That being said, this will be valid for OMAP2+ only and will still break OMAP1
> > platform :-(
> > 
> > Tony reported that 2 days ago, and I sent the fix for it.
> > http://www.mail-archive.com/linux-omap at vger.kernel.org/msg61520.html
> 
> Will drop patch 3 from my series.  Incidentally, it doesn't seem necessary 
> to wait for Ben's ack after commit 
> 046d0a37024a5b1e66ec9314e5e7feba42feb811 ("ARM: OMAP: I2C: fix compilation 
> when !CONFIG_OF"), unless Ben disagrees with that change.
> 
> 
> - Paul
