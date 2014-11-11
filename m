From: horms@verge.net.au (Simon Horman)
Date: Tue, 11 Nov 2014 09:15:08 +0900
Subject: [PATCH v3/resend] ARM: shmobile: Add early debugging support
 using SCIF(A)
In-Reply-To: <CAMuHMdUcZYTz4uLn4G9CECT5ZuKtHJuDZzR0WrzR3oo8qD3cfA@mail.gmail.com>
References: <1415273910-32356-1-git-send-email-geert+renesas@glider.be>
 <3499638.LG41cHl0JS@wuerfel>
 <CAMuHMdUU7XK57a70HWP0+nfwaZ-sXQ5EC2CShgmxwx6JKnuyPQ@mail.gmail.com>
 <20777697.th35W64j5e@wuerfel> <20141110005944.GE16836@verge.net.au>
 <CAMuHMdUcZYTz4uLn4G9CECT5ZuKtHJuDZzR0WrzR3oo8qD3cfA@mail.gmail.com>
Message-ID: <20141111001507.GB29665@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 10, 2014 at 09:03:23AM +0100, Geert Uytterhoeven wrote:
> On Mon, Nov 10, 2014 at 1:59 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Nov 06, 2014 at 02:26:45PM +0100, Arnd Bergmann wrote:
> >> On Thursday 06 November 2014 13:33:58 Geert Uytterhoeven wrote:
> >> > On Thu, Nov 6, 2014 at 12:53 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > > On Thursday 06 November 2014 12:38:30 Geert Uytterhoeven wrote:
> >> > >> Add serial port debug macros for the SCIF(A) serial ports.
> >> > >> This includes all shmobile SoCs, except for EMEV2.
> >> >
> >> > > I don't object to this patch going in, but have you looked at doing
> >> > > just earlycon instead? We are still missing some fixmap changes
> 
> > This patch feels like is is ready for me to queue up.
> > Is that the consensus here?
> 
> Please wait for v3, which will get rid of the multi-level choice statements,
> as requested by Arnd.

Sure, will do.
