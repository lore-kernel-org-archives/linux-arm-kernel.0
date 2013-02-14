From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 13 Feb 2013 20:14:06 -0800 (PST)
Subject: [PATCH] ARM: shmobile: r8a7779: Correct TMU clock support again
In-Reply-To: <878v6rv8ij.wl%kuninori.morimoto.gx@renesas.com>
References: <1360813381-3416-1-git-send-email-horms+renesas@verge.net.au>
 <87a9r7v8xd.wl%kuninori.morimoto.gx@renesas.com>
 <CANqRtoQtROi1cD3MmykhKLqY+1Y2=f+1Qkmw2bjAaP6yZRPW=Q@mail.gmail.com>
 <878v6rv8ij.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <877gmbv8fp.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Magnus, Simon again

> > Usually, the TMU channels are bundled together. So TMU00 may be for
> > channel 0->3 and TMU01 for 4->6.
> 
> This means that current TMU02 numbering seems doubtful too ?
> How about just rever 58079fa7d54a0929d304054ee759187a2ccd3cdf ?

I meant there is no tmu2 code on setup.c

Best regards
---
Kuninori Morimoto
