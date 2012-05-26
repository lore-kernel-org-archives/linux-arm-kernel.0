From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 May 2012 08:29:19 +0000
Subject: [PATCH 6/6] serial: add amba-pl011-pci
In-Reply-To: <20120526075855.GA1702@mail.gnudd.com>
References: <201205260739.31653.arnd@arndb.de>
 <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
 <20120526075855.GA1702@mail.gnudd.com>
Message-ID: <201205260829.19232.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 May 2012, Alessandro Rubini wrote:
> > Aside from the dma mask, this looks almost entirely generic. Would it
> > be possible to make this a generic pci-amba driver that lives under
> > drivers/amba/ and does not care about the type of device behind it?
> 
> Yes, it's possible. Actually, this was my longer-time plan: propose a
> factorization when more of those were ready.  So I'll remove the
> special name in the device and offer an implementation as generic
> as possible.
> 
> BTW, are the prerequisite patches of with you?
> 

Yes, they all look good to me, although patch 5 would have to change
if you do patch 6 the way we discussed here.

	Arnd
