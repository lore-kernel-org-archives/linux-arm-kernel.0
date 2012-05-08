From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 8 May 2012 10:10:18 -0600 (MDT)
Subject: Broken UART I/O wakeups on v3.4-rc4+
In-Reply-To: <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
References: <alpine.DEB.2.00.1205072249090.9984@utopia.booyaka.com>
 <CAMrsUdL2ekriQfyM2QqK1h-Wv+r80sk38p8-NYnRJdd9x8UwCw@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1205081006480.9984@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 May 2012, Raja, Govindraj wrote:

> On Tue, May 8, 2012 at 10:35 AM, Paul Walmsley <paul@pwsan.com> wrote:
>
> >
>
> The same is discussed in this thread as in here: 
> http://www.spinics.net/lists/linux-omap/msg68659.html

OK.

> > Could you please fix this? ?We probably aren't too far from the v3.5 merge
> > window opening, so there isn't much time to fix it.
> 
> okay, one possible solution is to probe pins dynamically
> and make rx wakeup capable which myself and Tony
> discussed and came up with this patch [1]
> 
> or to add rx wakeup pad support for each board,
> based on uart used as console.

Oh well, sounds like UART I/O wakeups are going to be broken in v3.4 :-(

Do you have a patch ready for Tony to queue for v3.5 to fix this?  From 
the above thread, it looks like Tony had some remaining comments to be 
addressed on your patch.


- Paul
