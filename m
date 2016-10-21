From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 21 Oct 2016 15:44:49 +0200
Subject: [PATCH v2 0/2] Assign RK3066 clocks at boot time
In-Reply-To: <58a16125-d0bd-1019-eee3-615b35c71c6a@gmail.com>
References: <cover.1476447057.git.paweljarosz3691@gmail.com>
 <1569308.lsrqUgJ5m1@phil> <58a16125-d0bd-1019-eee3-615b35c71c6a@gmail.com>
Message-ID: <13309666.zpbVPubHs9@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 14. Oktober 2016, 16:11:26 CEST schrieb Pawe? Jarosz:
> W dniu 14.10.2016 o 15:28, Heiko Stuebner pisze:
> > changes look good. One thing to keep in mind is that we need clock-id
> > additions in a separate patch (as they need to be on a shared branch).
> > 
> > I can do this split of patch1 on my own here, so no need to resend the
> > series and will do that after 4.9-rc1 (probably somewhere after sunday)
> > as I need a stable base for that shared branch.
> > 

As written before, I've now split up patch1 into two and applied all 3 patches 
for 4.10


Thanks
Heiko
