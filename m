From: svenkatr@ti.com (S, Venkatraman)
Date: Fri, 22 Jun 2012 23:53:33 +0530
Subject: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
In-Reply-To: <1340372890-10091-3-git-send-email-rnayak@ti.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-3-git-send-email-rnayak@ti.com>
Message-ID: <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
> and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
> probe() and remove() routines.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> Cc: Chris Ball <cjb@laptop.org>
> Cc: Balaji T K <balajitk@ti.com>
> Cc: <linux-mmc@vger.kernel.org>

Rajendra,
  Can this be applied independently, or does this patch have a
dependency on other patches in the series ?
