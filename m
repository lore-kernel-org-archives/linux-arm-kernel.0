From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 14:31:45 +0100
Subject: Do we have people interested in device tree janitoring / cleanup?
In-Reply-To: <20130725112558.GD24642@n2100.arm.linux.org.uk>
References: <CAOesGMge5hCDCeXYHXanaF1vR8mngBwdjhNbzD+Tc2EDUPRgCQ@mail.gmail.com>
 <20130725110634.GB2546@localhost.localdomain>
 <20130725112558.GD24642@n2100.arm.linux.org.uk>
Message-ID: <20130725133145.GE9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 12:25:58PM +0100, Russell King - ARM Linux wrote:

> That means whoever is doing the review of DT bindings probably needs to
> have access to documentation on the hardware - or they need to be educated
> by the submitter.  Or, we need submitters to individually justify why
> each and every property is required in the description.

My general strategy on that is to complain about any binding which isn't
comprehensible just from the binding document, plus pushing back on
anything that the driver really ought to be able to work out
automatically at runtime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/34e215b4/attachment.sig>
