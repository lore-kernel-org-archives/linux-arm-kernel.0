From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Jul 2014 19:32:43 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140703173226.GC17372@arm.com>
References: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703170558.GZ32514@n2100.arm.linux.org.uk>
 <20140703173226.GC17372@arm.com>
Message-ID: <20140703183243.GN410@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 06:32:26PM +0100, Will Deacon wrote:
> On Thu, Jul 03, 2014 at 06:05:58PM +0100, Russell King - ARM Linux wrote:

> > +1 on all points above.  I'd go further - if we're going to say that v8
> > still supports 32-bit apps, that covers at least v6 *as well*.

> We've never pretended to support anything other than ARMv8 in the compat
> layer. uname even reports this in the machine name.

That may have been the intention but sadly I rather suspect you'll find
that this doesn't match what users have been understanding.

> By the arguments presented so far, I can't see why we wouldn't also need
> OABI too. In other words, where do we draw the line? If we're not completely
> compatible, then the compatibility argument suddenly becomes subjective.

> It seems that people really want us to implement the subset of the ABI which
> is needed by the Google Play store and are trying to dress that up as the
> ARMv7 kernel ABI. The latter is a lot more work and conflating the two isn't
> especially helpful.

Right, or at least that's the set where there is the combination of
caring and time/ability to implement required to do the work to provide
the compatibility which is probably the real metric.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140703/0afe6d31/attachment.sig>
