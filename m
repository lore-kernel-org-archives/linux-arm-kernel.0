From: robie.basak@canonical.com (Robie Basak)
Date: Mon, 24 Mar 2014 09:57:23 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140323032939.GD30885@cbox>
References: <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk>
 <531843EE.8040102@redhat.com> <53185FB9.1040308@redhat.com>
 <20140306120449.GA29916@mal.justgohome.co.uk>
 <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
 <20140322010206.GF25519@cbox> <532D4505.1090603@redhat.com>
 <20140323031952.GB30885@cbox> <20140323032939.GD30885@cbox>
Message-ID: <20140324095723.GJ23363@mal.justgohome.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thank you all for considering this case in more detail.

On Sat, Mar 22, 2014 at 08:29:39PM -0700, Christoffer Dall wrote:
> After thinking about this a bit more, I think I see what we're actually
> discussing.  It's obvious that if software in a VM makes changes to UEFI
> variables that are required to be persistent for that VM image to boot
> again, then the VM image is no longer portable, as per the spec.

No longer portable, and given the current state of implementation, no
longer bootable, since we don't support persistent storage yet;
certainly not on OpenStack? Or do we have that now?

Are we really pushing ahead with a specification that nobody can
implement today? How far away are we from a fully compliant
implementation?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140324/6e1da7b1/attachment.sig>
