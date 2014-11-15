From: broonie@kernel.org (Mark Brown)
Date: Sat, 15 Nov 2014 13:40:42 +0000
Subject: [PATCH] arm64: topology: Fix handling of multi-level cluster
 MPIDR-based detection
In-Reply-To: <20141112150756.GA30300@e102568-lin.cambridge.arm.com>
References: <1408462379-27968-1-git-send-email-broonie@kernel.org>
 <CAFpQJXWkL_ge8XT9y6vSNwgQgXcvQtUh4PaWxdH1dK0QhFWu2A@mail.gmail.com>
 <20141003163715.GB13939@e102568-lin.cambridge.arm.com>
 <20141008205628.GO4609@sirena.org.uk>
 <20141112150756.GA30300@e102568-lin.cambridge.arm.com>
Message-ID: <20141115134042.GM3815@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 12, 2014 at 03:07:56PM +0000, Lorenzo Pieralisi wrote:
> On Wed, Oct 08, 2014 at 09:56:28PM +0100, Mark Brown wrote:

> > > I think that's what we should do, squash the upper MPIDR levels (for
> > > the non SMT case too). Please stick a proper comment for that to the code.
> > > We can always rely on DT to fix other cases that can't be treated
> > > properly with code above.

> > OK, I'll send a patch.

> do you have time to send it ?

Should do.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141115/faa8b71d/attachment.sig>
