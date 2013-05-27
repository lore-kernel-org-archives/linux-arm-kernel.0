From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 27 May 2013 14:38:54 +0100
Subject: [RFC patch 1/8] genirq: generic chip: Remove the local cur_regs()
 function
In-Reply-To: <20130503214629.397359626@linutronix.de>
References: <alpine.LFD.2.02.1305031514230.2886@ionos>
 <20130503212258.385818955@linutronix.de>
 <20130503214629.397359626@linutronix.de>
Message-ID: <CACxGe6tyLY3+arq2iwTZWVJ73zOtAemstX-E98i=Mo3kNjqHRw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 3, 2013 at 10:50 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> From: Gerlando Falauto <gerlando.falauto@keymile.com>
>
> Since we already have an irq_data_get_chip_type() function which returns
> a pointer to irq_chip_type, use that instead of cur_regs().
>
> Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
> Cc: Lennert Buytenhek <kernel@wantstofly.org>
> Cc: Simon Guinot <simon@sequanux.org>
> Cc: Joey Oravec <joravec@drewtech.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Nicolas Pitre <nico@fluxnic.net>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Holger Brunck <Holger.Brunck@keymile.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
