From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Sun, 13 Oct 2013 18:23:31 +0200
Subject: [PATCHv2] Route kbd LEDs through the generic LEDs layer
In-Reply-To: <20131008160152.a98961b9e54bf1c45c1818dc@linux-foundation.org>
References: <20130717152916.GI5883@type.bordeaux.inria.fr>
 <20130904172621.GA5957@type.bordeaux.inria.fr>
 <20131008160152.a98961b9e54bf1c45c1818dc@linux-foundation.org>
Message-ID: <20131013162331.GU14778@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Andrew Morton, le Tue 08 Oct 2013 16:01:52 -0700, a ?crit :
> Do you believe that the earlier controversies are now addressed and if
> so, how?

Yes.  Dmitry thought more about how to integrate that nicely on 12th
Jan 2011, which I did.  The patch was rebased on 3.x, and I submitted a
reworked patch on 21st Dec 2012. David Herrmann did a code review, which
were answered by small changes.

> Have the earlier participants in that discussion been cc'ed
> and have they commented?

I believe they have all been cc'ed.  They have not provided more
comments.

> In other words, how are we generally getting along with those things?  

I believe this is ready, just Dmitry didn't have time to process it yet.

> The one-line change to drivers/tty/vt/keyboard.c no longer applies -
> LED_SHOW_MEM has vanished altogether.

Good thing :)

Thanks,
Samuel
