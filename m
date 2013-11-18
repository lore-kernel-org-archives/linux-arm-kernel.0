From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 15:00:52 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <5289A356.4060004@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
Message-ID: <20131118150052.GC24408@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 18, 2013 at 12:19:18AM -0500, Jon Masters wrote:

> has an API enshrined in stone as far as compatibility. Device Tree is
> wonderful, anyone can make a binding and use it. Or change the binding
> in the next kernel release. Or...this doesn't work in the server space.

This isn't really a property of DT, it's a property of the way people
have been using the DT - people have been running with baked in DTs on
PowerPC and SPARC systems for quite some time now.  It's not obvious how
writing the data out in one format rather than another addresses this.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/feb59cb5/attachment.sig>
