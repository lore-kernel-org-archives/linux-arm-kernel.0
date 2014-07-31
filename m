From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 31 Jul 2014 19:37:30 +0200
Subject: [PATCH] Documentation: dmaengine: Add a documentation for the
 dma controller API
In-Reply-To: <53DA74B3.6060502@metafoo.de>
References: <1406736193-26685-1-git-send-email-maxime.ripard@free-electrons.com>
 <20140730160607.GM8181@intel.com> <20140731074440.GY3952@lukather>
 <53DA3A48.8070900@metafoo.de> <20140731161331.GD3952@lukather>
 <53DA74B3.6060502@metafoo.de>
Message-ID: <20140731173730.GH3952@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 06:54:11PM +0200, Lars-Peter Clausen wrote:
> On 07/31/2014 06:13 PM, Maxime Ripard wrote:
> [...]
> > From what you're saying, and judging from the drivers that already
> >implement it, can't it be moved directly to the framework itself ?
> >
> 
> What exactly do you mean by moving it directly to the framework? The
> slave_caps API is part of the DMAengine framework.

Not its implementation, which is defined by each and every driver,
while the behaviour of device_slave_caps is rather generic.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140731/10d5f63e/attachment-0001.sig>
