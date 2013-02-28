From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 1 Mar 2013 00:25:58 +0100
Subject: [PATCH v3 0/2] Add automatic bus number support for i2c busses
 with device tree
In-Reply-To: <CAD=FV=WS5Vj74d-FNXCVpNsx6Nf-8+RC-WO29Z1XNmkEOYLxfQ@mail.gmail.com>
References: <1360630085-26874-1-git-send-email-dianders@chromium.org>
 <CAD=FV=WS5Vj74d-FNXCVpNsx6Nf-8+RC-WO29Z1XNmkEOYLxfQ@mail.gmail.com>
Message-ID: <20130228232558.GA8180@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > Doug Anderson (2):
> >   i2c-core: dt: Pick i2c bus number from i2c alias if present
> >   i2c: pxa: Use i2c-core to get bus number now
> >
> >  drivers/i2c/busses/i2c-pxa.c | 20 ++++++++--------
> >  drivers/i2c/i2c-core.c       | 54 ++++++++++++++++++++++++++++++++------------
> >  2 files changed, 49 insertions(+), 25 deletions(-)
> 
> Is there anything else needed for this patch series?  It's been
> hanging around for quite a while and it would be nice to see it land.
> If you're waiting for additional acks or reviews I'll ask around and
> see if I can get them...

Regarding patch 1, I was waiting for the idr changes to hit mainline.
They are mainline now, but since the removal of MAX_IDR_MASK your patch
doesn't apply anymore :( Can you rebase and retest, please? I'd like to
get it into 3.9, still.

For patch 2, some Tested-by would be nice; but it will probably make it
into my for-next somewhen after rc1 is out.

Thanks,

   Wolfram
