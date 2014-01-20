From: horms@verge.net.au (Simon Horman)
Date: Mon, 20 Jan 2014 09:31:36 +0900
Subject: [PATCH 1/2] ARM: shmobile: Lager: pass Ether PHY IRQ
In-Reply-To: <CANqRtoQ_qPBJUqnbU6wrrc+tmsspk_v99w-ZTdnhPivEdBzd4A@mail.gmail.com>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200219.31121.sergei.shtylyov@cogentembedded.com>
 <CANqRtoQ_qPBJUqnbU6wrrc+tmsspk_v99w-ZTdnhPivEdBzd4A@mail.gmail.com>
Message-ID: <20140120003133.GF9752@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 03:00:29PM +0900, Magnus Damm wrote:
> On Fri, Dec 20, 2013 at 8:19 AM, Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> > trigger type to be low-level as per the Micrel PHY driver's setup.
> >
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >
> > ---
> >  arch/arm/mach-shmobile/board-lager.c |    4 ++++
> >  1 file changed, 4 insertions(+)
> 
> Thanks for your efforts. The code looks fine. I have now also tested
> this on my Lager board.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Hi Sergei,

please repost this patch with Magnus's ack once an rc release is
available with the pre-requisites of this patch.

Thanks
