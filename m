From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 23 Apr 2014 15:10:08 +0200
Subject: [PATCH v5 7/7] ARM: sun6i: dt: Add A31 DMA controller to DTSI
In-Reply-To: <201404231435.03920.arnd@arndb.de>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394723659-4995-8-git-send-email-maxime.ripard@free-electrons.com>
 <201404231435.03920.arnd@arndb.de>
Message-ID: <20140423131008.GQ24905@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 02:35:03PM +0200, Arnd Bergmann wrote:
> On Thursday 13 March 2014, Maxime Ripard wrote:
> > Now that we have a DMA driver, we can add the DMA bindings in the DTSI for the
> > controller and the devices supported that can use DMA.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> But why does this patch have to wait for the driver to get merged?

I wanted to make sure that my bindings were ok, and at least reviewed
by someone, but I guess it's done now.

Just applied it.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140423/653c359c/attachment.sig>
