From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 2 Jul 2012 17:23:20 +0200
Subject: [PATCH 07/29] mfd: omap-usb: use clk_prepare_enable and
 clk_disable_unprepare
In-Reply-To: <4FF18305.2020301@ti.com>
References: <1339678038-23082-1-git-send-email-rnayak@ti.com>
 <1339678038-23082-8-git-send-email-rnayak@ti.com>
 <20120702111850.GC22065@sortiz-mobl> <4FF18305.2020301@ti.com>
Message-ID: <20120702152320.GP22065@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rajendra,

On Mon, Jul 02, 2012 at 04:46:21PM +0530, Rajendra Nayak wrote:
> Hi Samuel,
> 
> On Monday 02 July 2012 04:48 PM, Samuel Ortiz wrote:
> >Hi Rajendra,
> >
> >On Thu, Jun 14, 2012 at 06:16:56PM +0530, Rajendra Nayak wrote:
> >>As we move to Common clk framework use clk_prepare_enable()
> >>instead of clk_enable() and similarly clk_disable_unprepare()
> >>instead of clk_disable()
> >>
> >>Signed-off-by: Rajendra Nayak<rnayak@ti.com>
> >>Cc: Samuel Ortiz<sameo@linux.intel.com>
> >>---
> >>  drivers/mfd/omap-usb-host.c |   28 ++++++++++++++--------------
> >>  1 files changed, 14 insertions(+), 14 deletions(-)
> >Patch applied, many thanks.
> 
> Sorry, I was asked to base these changes on top of work done by
> Keshava [1], to split the driver, which is still under review/not
> pulled.
> I am waiting for those to settle to repost these changes.
> Can you please drop this one for now?
I just did, although I think Keshava could have based his work on top of
yours, as he's rebasing his patchset at the moment.
Anyway, patch is removed now.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
