From: horms@verge.net.au (Simon Horman)
Date: Wed, 5 Jun 2013 22:49:21 +0900
Subject: [PATCH 1/4] irqchip: irqc: Add runtime PM support
In-Reply-To: <CANqRtoTxxtj-uKyM58dKfH6GV62G8nweQeh9W3+VW==USOkj9A@mail.gmail.com>
References: <1370406751-3852-1-git-send-email-horms+renesas@verge.net.au>
 <1370406751-3852-2-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTxxtj-uKyM58dKfH6GV62G8nweQeh9W3+VW==USOkj9A@mail.gmail.com>
Message-ID: <20130605134920.GB7451@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 04:03:26PM +0900, Magnus Damm wrote:
> Hi Simon and Morimoto-san,
> 
> On Wed, Jun 5, 2013 at 1:32 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > This was tested using the SMSC LAN on the APE6EVM board.
> >
> > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  drivers/irqchip/irq-renesas-irqc.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> 
> Thanks for your patch. I am trying to understand how this controls the
> actual hardware. Which clock and/or power domain is being controlled
> using this patch?

This patch appears to resolve a problem which I discussed with
Morimoto-san on the linux-sh ML and for which he proposed this solution.
However, I never fully analysed its effect. I think that
the best thing would be for me to drop this patch from the
renesas tree for now it and come back to this problem later.
