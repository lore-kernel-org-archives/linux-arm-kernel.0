From: inki.dae@samsung.com (In-Ki Dae)
Date: Fri, 02 Jul 2010 02:35:26 +0000 (GMT)
Subject: [PATCH 1/3] FB: Add some members for CPU Interface.
Message-ID: <30082026.20641278038126412.JavaMail.weblogic@epml12>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ok, andrew

I will add descriptions to these variables also apply commends of other developers.

Thank you.
------- Original Message -------
Sender : Andrew Morton<akpm@linux-foundation.org> 
Date   : 2010-07-02 10:46 (GMT+09:00)
Title  : Re: [PATCH 1/3] FB: Add some members for CPU Interface.

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
