From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Sun, 17 Dec 2017 15:53:05 +0100
Subject: pxa3xx_nand times out in 4.14 with JFFS2
In-Reply-To: <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
References: <20171217120503.GA3323@1wt.eu>
 <CAAEAJfBUyhvi68A6QEJRywq9hxMBYuJ4m+O6ogBtV1nkeBR_og@mail.gmail.com>
Message-ID: <20171217155305.16c5bb4f@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 17 Dec 2017 11:27:51 -0300
Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:

> On 17 December 2017 at 09:05, Willy Tarreau <w@1wt.eu> wrote:
> > Hello,
> >
> > I recently bought a Linksys WRT1900ACS which hosts an Armada 385 and a
> > NAND flash. While I could get OpenWRT to work flawlessly on it using
> > kernel 4.4, mainline 4.14.6 fails with a lot of such messages :
> >
> >     pxa3xx-nand f10d0000.flash: Wait time out!!!
> >  
> 
> Boris,
> 
> Any idea why this issue is on v4.14, but not observed on v4.4?

I have absolutely no idea.

> 
> Also, is this somehow related to Armada 385 only?

I doubt it. My guess is that almost nobody uses JFFS2 these days, which
may explain why this problem has not been detected before.
