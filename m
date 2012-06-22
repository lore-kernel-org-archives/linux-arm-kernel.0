From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 22 Jun 2012 12:34:07 -0600 (MDT)
Subject: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
In-Reply-To: <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-3-git-send-email-rnayak@ti.com>
 <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Jun 2012, S, Venkatraman wrote:

> On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> > In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> > and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
> > probe() and remove() routines.
> >
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> > Cc: Chris Ball <cjb@laptop.org>
> > Cc: Balaji T K <balajitk@ti.com>
> > Cc: <linux-mmc@vger.kernel.org>
> 
> Rajendra,
>   Can this be applied independently, or does this patch have a
> dependency on other patches in the series ?

A better way to handle this one would be to convert the driver to runtime 
PM.  That needs to be done anyway.


- Paul
