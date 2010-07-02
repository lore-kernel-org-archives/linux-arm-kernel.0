From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 1 Jul 2010 18:46:46 -0700
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
In-Reply-To: <5572310.15091278033672605.JavaMail.weblogic@epml12>
References: <5572310.15091278033672605.JavaMail.weblogic@epml12>
Message-ID: <20100701184646.0d33340c.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 02 Jul 2010 01:21:12 +0000 (GMT) In-Ki Dae <inki.dae@samsung.com> wrote:

> Hi, Andrew,
> 
> cpu timing variables could be used generically.
> now fb.h and modedb.c file have been considered only for video mode.
> but the way of transfering screen data includes also command mode(cpu mode or i80 mode)
> so I thought it should be added things for it to fb_varscreeninfo struct.
> 
> Could you please tell me why cpu timing variables are specific to s3c-fb?

I dunno - I was just looking at the code.

I don't even know what "cpu timing variables" _are_, in the context of
video drivers.  Look at this:

> > CPU interface needs cs, wr setup, wr act and hold delay.
> > I added some members for them to common framework.

It's gobbledigook!  Please, write patch descriptions which help poor
dumb people who don't have detailed knowledge of the particular
hardware understand your patch?
