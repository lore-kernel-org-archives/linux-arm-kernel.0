From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 28 Nov 2018 22:44:45 +0100
Subject: [PATCH v4 0/20] MMP platform fixes
In-Reply-To: <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
References: <20181128175324.163202-1-lkundrak@v3.sk>
 <CAK8P3a0jN1PBy1oKHrx5abX4OKHVxjgevbUcXbUDPbU+VdvUPg@mail.gmail.com>
Message-ID: <20181128214445.GF20670@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > this series contains contains a bunch of MMP2 platform fixes.
> >
> > Previous spins of the patch set were sent out over the course of last
> > three months to the MMP platform maintainers, with Arnd and
> > linux-arm-kernel at lists.infradead.org on copy.
> >
> > Unfortunatelly, MMP maintainers (Eric Miao and Haojian Zhuang) don't
> > seem to respond anymore. That's a shame, because the MMP2 support seems to
> > in need for some love. The DT/multiplatform kernels can't even boot without
> > 14/20, 15/20 and perhaps more.
> >
> > I'm wondering if this cat gen in via the arm-soc tree? Would it be
> > appropriate if I followed up with a MAINTAINERS update in that case?
> 
> Yes, sounds good to me. I looked through the series again, and
> found one patch that seems wrong to me. Everything else should
> just go in.

Sounds good to me.

> Patches that are purely bugfixes should probably also get backported
> to stable kernels, so please add a 'Cc: stable at vger.kernel.org' tag
> in the changelog for things that are required to make older kernels
> work correctly (as opposed to adding features that were never supposed
> to work), and describe in the changelog which kernel versions should
> see that backport.

Dunno, I'd be careful there. MMP2 was broken long ago and mainline
never booted on olpc-1.75 AFAICT. Seems like noone cares about
MMP2. I'd just keep it out of stable; stable is for bugs when someone
cares.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181128/ae023e27/attachment.sig>
