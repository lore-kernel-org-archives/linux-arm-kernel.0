From: horms@verge.net.au (Simon Horman)
Date: Wed, 27 Mar 2013 13:49:30 +0900
Subject: [PATCH 0/3 v3] ARM: shmobile: add R8A7778 Bock-W board support v3
In-Reply-To: <CANqRtoTRPN8esU-iiQNtr3f6gZ1gAiXHMHZzXw2cFoBEPNW1VA@mail.gmail.com>
References: <87hakhrpmn.wl%kuninori.morimoto.gx@renesas.com>
 <878v5hf4zr.wl%kuninori.morimoto.gx@renesas.com>
 <20130321104127.GH2348@verge.net.au>
 <CANqRtoTRPN8esU-iiQNtr3f6gZ1gAiXHMHZzXw2cFoBEPNW1VA@mail.gmail.com>
Message-ID: <20130327044929.GA8426@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 26, 2013 at 11:19:05PM +0900, Magnus Damm wrote:
> Hi Simon, Morimoto-san,
> 
> On Thu, Mar 21, 2013 at 7:41 PM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Mar 21, 2013 at 06:59:20PM +0900, Kuninori Morimoto wrote:
> >>
> >> Hi Simon, Magnus, Arnd
> >>
> >> These are v3 patch set of R8A7778 R-Car M1 SoC/board support
> >> This SoC/board support have limited DT only.
> >> (TMU/SCIF can't use DT at this point)
> >>
> >> I will work for external IRQ and SMSC support
> >> if these are accepted.
> >>
> >> These patches are based on simon/next branch
> >
> > Good choice :^)
> >
> > I have no objections to these changes at this point
> > but I would appreciate an ack from Magnus before applying them.
> 
> I've looked through this series and they look good to me.
> 
> Acked-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue them up.
