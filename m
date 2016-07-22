From: rric@kernel.org (Robert Richter)
Date: Fri, 22 Jul 2016 14:11:00 +0200
Subject: [RFC PATCH v4 3/5] PCI: Check platform specific ECAM quirks
In-Reply-To: <CAKv+Gu9jfHGF3Z=_yA2rR9v3MGWptom4x1Mm=eGxmB0xoBpqoA@mail.gmail.com>
References: <1467100442-28078-1-git-send-email-tn@semihalf.com>
 <1467100442-28078-4-git-send-email-tn@semihalf.com>
 <577275EA.7010002@codeaurora.org>
 <CADaLNDkhPZuG7UJ4SK_j5v_nXbd782Q17LAcXduG0uEObaFF=g@mail.gmail.com>
 <5773A773.8040700@semihalf.com> <5773CE49.1050802@codeaurora.org>
 <CAKv+Gu9=0=qw70o1aYNg=tDyv4TguiG2WwXNK8RbWM1-ZcabUg@mail.gmail.com>
 <20160722113809.GM25086@rric.localdomain>
 <CAKv+Gu9jfHGF3Z=_yA2rR9v3MGWptom4x1Mm=eGxmB0xoBpqoA@mail.gmail.com>
Message-ID: <20160722121100.GN25086@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.07.16 14:00:42, Ard Biesheuvel wrote:
> On 22 July 2016 at 13:38, Robert Richter <rric@kernel.org> wrote:

> > And, we should support some sort of MCFG_OEM_REVISION_ANY to move the
> > rev handling optional to pci_cfg_fixup::init().
> >
> 
> xxx_ANY implies 'wildcard', which we don't want in this code. The set
> of quirky hardware we intend to support is known, and wildcard
> matching makes it easier to circumvent our policy that from here on,
> i.e., that all ACPI/arm64 supported hardware shall adhere to the spec.

Fine with me, there shouln't be to many revs around to have a quirk
per rev.

-Robert
