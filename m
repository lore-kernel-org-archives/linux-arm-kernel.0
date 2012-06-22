From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 22 Jun 2012 13:14:45 +0800
Subject: [PATCH] clk: mxs: mx23, mx28: fix clock lookup after freeing
 init memory
In-Reply-To: <CAJOA=zNeSPdNrP0Z8ymaYMjHA4dVoBrPSEWrumNXT04gVQak-w@mail.gmail.com>
References: <1340301865-15815-1-git-send-email-mkl@pengutronix.de>
 <20120622020726.GC21418@S2101-09.ap.freescale.net>
 <CAJOA=zNeSPdNrP0Z8ymaYMjHA4dVoBrPSEWrumNXT04gVQak-w@mail.gmail.com>
Message-ID: <20120622051443.GE21418@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 07:52:30PM -0700, Turquette, Mike wrote:
> Looks like a clk-fixes branch is in order.  There are at least three
> fixes that need to into the 3.5 bugfix window.  I'll push such a
> branch to my linaro git tree tomorrow.
> 
To ease your life a little bit, here are the fixes for clk/mxs.

Regards,
Shawn

---

The following changes since commit cfaf025112d3856637ff34a767ef785ef5cf2ca9:

  Linux 3.5-rc2 (2012-06-08 18:40:09 -0700)

are available in the git repository at:
  git://git.linaro.org/people/shawnguo/linux-2.6.git clk/mxs/fixes-for-3.5

Marc Kleine-Budde (1):
      clk: mxs: fix clock lookup after freeing init memory

Shawn Guo (1):
      clk: mxs: fix ref_io clock definition

 drivers/clk/mxs/clk-imx23.c |   12 ++++++------
 drivers/clk/mxs/clk-imx28.c |   32 ++++++++++++++++----------------
 2 files changed, 22 insertions(+), 22 deletions(-)
