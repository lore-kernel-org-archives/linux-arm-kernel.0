From: broonie@kernel.org (Mark Brown)
Date: Mon, 6 Mar 2017 11:58:05 +0100
Subject: [RFC PATCH 00/12] Ion cleanup in preparation for moving out of
 staging
In-Reply-To: <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
References: <1488491084-17252-1-git-send-email-labbott@redhat.com>
 <20170303132949.GC31582@dhcp22.suse.cz>
 <cf383b9b-3cbc-0092-a071-f120874c053c@redhat.com>
 <20170306074258.GA27953@dhcp22.suse.cz>
 <20170306104041.zghsicrnadoap7lp@phenom.ffwll.local>
Message-ID: <20170306105805.jsq44kfxhsvazkm6@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 06, 2017 at 11:40:41AM +0100, Daniel Vetter wrote:

> No one gave a thing about android in upstream, so Greg KH just dumped it
> all into staging/android/. We've discussed ION a bunch of times, recorded
> anything we'd like to fix in staging/android/TODO, and Laura's patch
> series here addresses a big chunk of that.

> This is pretty much the same approach we (gpu folks) used to de-stage the
> syncpt stuff.

Well, there's also the fact that quite a few people have issues with the
design (like Laurent).  It seems like a lot of them have either got more
comfortable with it over time, or at least not managed to come up with
any better ideas in the meantime.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170306/a9d7cff2/attachment.sig>
