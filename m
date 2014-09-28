From: broonie@kernel.org (Mark Brown)
Date: Sun, 28 Sep 2014 13:25:43 +0100
Subject: [PATCH v1 1/3] regulator: act8865: Add support to turn off all
 outputs
In-Reply-To: <CABgxDo+h2AYjAO4darK4+RTXqnhf4OqouGLfF2yuJCpu7r6tLg@mail.gmail.com>
References: <1411834906-9533-1-git-send-email-romain.perier@gmail.com>
 <20140928103301.GN27755@sirena.org.uk>
 <CABgxDo+h2AYjAO4darK4+RTXqnhf4OqouGLfF2yuJCpu7r6tLg@mail.gmail.com>
Message-ID: <20140928122543.GA27755@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 28, 2014 at 02:00:54PM +0200, PERIER Romain wrote:
> 2014-09-28 12:33 GMT+02:00 Mark Brown <broonie@kernel.org>:

> > We really need to come up with a standard property for this and document
> > it rather than continuing to add individual device specific properties
> > all doing the same thing, and probably also some helper code and/or a
> > standard operation for this - there's a lot of drivers implementing the
> > same pattern here.

> I completly agree about adding a unified and generic property for that purpose.
> I already proposed something for that on devicetree ML, see the thread
> "Proposal: generic property for system-power-controller".
> Unfortunately I did not get replies :) .

Did you CC relevant maintainers and send a patch?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140928/a69323c8/attachment.sig>
