From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 23 Oct 2012 12:41:31 +0100
Subject: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
In-Reply-To: <20121023111656.GT21164@n2100.arm.linux.org.uk>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
 <1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
 <CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
 <20121023111019.GV4477@opensource.wolfsonmicro.com>
 <20121023111656.GT21164@n2100.arm.linux.org.uk>
Message-ID: <20121023114130.GW4477@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2012 at 12:16:56PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 12:10:19PM +0100, Mark Brown wrote:

> > I *really* should not need to remind you to:

> >  - Not top post
> >  - Send patches in a form which can be applied if you want them applying

> How about actually applying the damned patch from the two-part patch set,
> rather than only the first, both of which has been around for almost a
> month now, and fixes what should never have gone into mainline in the
> first place?

Well, the reason for the second point is that I don't have a copy of the
patch any more, I need a copy of it before I can do anything.  Half the
reason these contentless top posts are annoying is that even if there's
something to do it's not actionable.

I have to say I had been under the impression that Linus' series that I
applied the other day dealt with all the outstanding stuff here; the
issues with this have been the awful changelogs and the overalapping
sets of patches.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121023/160443fc/attachment-0001.sig>
