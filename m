From: broonie@kernel.org (Mark Brown)
Date: Mon, 20 Oct 2014 12:15:28 +0100
Subject: arm64 build failures in -next
In-Reply-To: <CAPvkgC07KrZyx+--eUNb2OLz1wSCa-Gu4r3FkLoRFf4QjMFYrA@mail.gmail.com>
References: <E1Xg5Gy-00082k-6v@debutante>
 <20141020105210.GP18557@sirena.org.uk>
 <CAPvkgC07KrZyx+--eUNb2OLz1wSCa-Gu4r3FkLoRFf4QjMFYrA@mail.gmail.com>
Message-ID: <20141020111528.GQ18557@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 12:07:38PM +0100, Steve Capper wrote:
> On 20 October 2014 11:52, Mark Brown <broonie@kernel.org> wrote:

> > which appears to be due to "mm/gup.c: update generic gup implementation
> > to handle hugepage directory".  That patch added a default definition of
> > pgd_huge() in the !CONFIG_HUGETLB_PAGE case but only PowerPC provides an
> > actual definition of that function.

> The patch responsible for this has been removed from -mm (because of
> this issue), I think it will leave -next too?

It should do once a new -mm is published, I guess that's not happened
yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141020/a5e7f9c8/attachment.sig>
