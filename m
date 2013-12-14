From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 15 Dec 2013 00:39:46 +0100
Subject: [PATCH v2 03/16] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1387049660.7152.317.camel@host5.omatika.ru>
References: <1386543229-1542-1-git-send-email-ynvich@gmail.com>
 <201312142006.26979.arnd@arndb.de>
 <1387049660.7152.317.camel@host5.omatika.ru>
Message-ID: <201312150039.46681.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 14 December 2013, Sergei Ianovich wrote:
> On Sat, 2013-12-14 at 20:06 +0100, Arnd Bergmann wrote:
> > On Friday 13 December 2013, Sergei Ianovich wrote:
> > > Non-dts implementation supply required DMA channel numbers as
> > > IORESOURCE_DMA. However, there is was no way to get them from
> > > device tree.
> > 
> > Please update this changeset comment, I think it still refers to
> > the earlier version.
> 
> ---
> Non-dts implementation supply required DMA channel numbers as
> IORESOURCE_DMA. We can also get them from the device tree, if it
> is present.
> ---
> 
> Is this fine?

I would mention that the binding is designed to work with the dmaengine
framework as soon as we have figured out how to make that work without
the problems you found.

> Should I post v3, if so? 

I'd wait a little longer for more comments.

	Arnd
