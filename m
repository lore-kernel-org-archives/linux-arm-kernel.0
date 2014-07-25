From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Jul 2014 17:58:24 +0200
Subject: [PATCH 6/6 v4] ARM: realview: basic device tree implementation
In-Reply-To: <20140725155010.GP21766@n2100.arm.linux.org.uk>
References: <1406294628-16079-1-git-send-email-linus.walleij@linaro.org>
 <20140725152401.GA21830@leverpostej>
 <20140725155010.GP21766@n2100.arm.linux.org.uk>
Message-ID: <9626823.572BIYcQL9@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 July 2014 16:50:10 Russell King - ARM Linux wrote:
> 
> I toyed with the idea of adding the standard cache size specifications
> to the L2C code, it sounds like there's a reason to do that now.
> 
> Let's not mess around with adding stuff like the above to work around
> the L2 code not parsing the appropriate specs from DT, let's do the
> right thing and add bindings to allow DT to provide the cache geometry.

Yes, please!

That would actually reduce the realview to just the dma_zone_size
definition, and I think someone also posted a patch to get that from
DT recently. Having realview booting with an empty board file would
be ideal.

	Arnd
