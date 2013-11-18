From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Nov 2013 15:04:55 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <3371903.8j54vrCjEN@wuerfel>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <CAOesGMhkCn2zeJj_ZZAZu_wJya-4evWEqNHpVJEpjxzWHVWY3A@mail.gmail.com>
 <alpine.DEB.2.02.1311171705130.4714@kaball.uk.xensource.com>
 <3371903.8j54vrCjEN@wuerfel>
Message-ID: <20131118150455.GD24408@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 17, 2013 at 07:10:51PM +0100, Arnd Bergmann wrote:
> On Sunday 17 November 2013 17:18:03 Stefano Stabellini wrote:

> > Simply using DT would help avoiding the awkward situation where a driver
> > of a device only works with one of the two description formats and not
> > the other.

> Yes, but remember that Intel still have the problem on their embedded
> systems, and will want to solve them.

Has it been confirmed that Intel are going with ACPI for their embedded
devices rather than SFI?  That would be nice given how awful SFI is and
I have heard that before but I'm not sure I've seen anything official.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131118/965930a8/attachment.sig>
