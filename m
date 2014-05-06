From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 06 May 2014 16:27:25 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <53673866.9000105@ahsoftware.de>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131118150052.GC24408@sirena.org.uk> <20131119091216.GA4412@netboy>
 <20131120064056.GB5272@netboy>
 <20131121192136.GA16735@n2100.arm.linux.org.uk>
 <20131121204704.E4487C40753@trevor.secretlab.ca>
 <CAHkRjk5MstjD9JFk+co8k89i8geJBmSF6uObhGdmWSe0GJHo8g@mail.gmail.com>
 <97692EF2-013E-4E4B-BC16-E0915D67EFEC@antoniou-consulting.com>
 <53673866.9000105@ahsoftware.de>
Message-ID: <20140506152725.E5B90C40959@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 05 May 2014 09:06:14 +0200, Alexander Holler <holler@ahsoftware.de> wrote:
> Am 22.11.2013 13:00, schrieb Pantelis Antoniou:
> 
> > As one that's going to be dealing with this, please don't take the DTS
> > files from the kernel.
> >
> > If you do this, I can guarantee that within a year almost no ARM board using DT
> > will boot a mainline kernel.
> >
> > The reason is that vendors have enough trouble (and failing) tracking a single
> > tree, adding yet another will just end to the vendor trees as far as the eye can see.
> >
> > Maybe, maybe, EVMs from silicon vendors will still boot, but I doubt any other
> > customer board will work.
> 
> A bit late (I don't follow the ML (or what happens in the ARM world) 
> closely, but as I've recently read that ARM64 will go UEFI and ACPI, I 
> wonder what was the reasoning behind that decision.

ARM64 will include support for UEFI an ACPI, but U-Boot and DT are not
going away. Really the only market segment that will care about ACPI is
ARM servers. Nobody else (embedded, mobile) needs to worry about it.

g.
