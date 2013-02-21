From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 22 Feb 2013 10:13:59 +1100
Subject: [PATCH 01/11] ARM: disable virt_to_bus/virt_to_bus almost
 everywhere
In-Reply-To: <5125CED4.7030905@synopsys.com>
References: <1360849767-1463135-1-git-send-email-arnd@arndb.de>
 <1360849767-1463135-2-git-send-email-arnd@arndb.de>
 <CAAG0J9_VqCGJJJZjSWGfFggALHU=vdWsSBeS39-DtxV=VXcJwQ@mail.gmail.com>
 <201302201600.47522.arnd@arndb.de> <5124FA93.5090504@imgtec.com>
 <5125CED4.7030905@synopsys.com>
Message-ID: <20130222101359.0c91a7259f648a3d06221bd8@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, 21 Feb 2013 13:07:56 +0530 Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
> >> I guess you'll have to do something similar for arch/metag, and Vineet
> >> will do it for arch/arc.
> 
> After getting the tip-bot msg about Stephen's patch for -mm, I never saw it in
> -next and thus was not sure how when it will start showing up in -next.

It arrived in next-21030220.

> >> Stephen's patch is currently in Andrew's tree, and I don't see an easy
> >> way to coordinate this. The patch we will need once both are merged
> >> is below.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > FWIW:
> > Acked-by: James Hogan <james.hogan@imgtec.com> (for arch/metag)
> > 
> Acked-by: Vineet Gupta <vgupta@synopsys.com> (for arch/arc)
> 
> So this means Stephen's patch - once merged will take care of existing in-tree
> arches and your's will take care of metag/arc.

The easiest way would be to put the follow up patches in Andrew's patch
set (since it is still based on top of linux-next).  It usually is merged
pretty late, so I would get your own trees merged ASAP and this can be
taken care of when Andrew sends his patch set to Linus.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130222/bd744617/attachment-0001.sig>
