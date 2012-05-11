From: sameo@linux.intel.com (Samuel Ortiz)
Date: Fri, 11 May 2012 11:40:09 +0200
Subject: [PATCH 2/2] mfd: twl: remove pdata->irq_base/_end, no more users
In-Reply-To: <1336497542-13629-3-git-send-email-khilman@ti.com>
References: <1336497542-13629-1-git-send-email-khilman@ti.com>
 <1336497542-13629-3-git-send-email-khilman@ti.com>
Message-ID: <20120511094009.GD1214@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

On Tue, May 08, 2012 at 10:19:02AM -0700, Kevin Hilman wrote:
> After converstion to SPARSE_IRQ, the driver doesn't use the
> pdata->irq_base/irq_end fields anymore.  The last users
> have been cleanup up, and now these fields can be removed.
> 
> Cc: Benoit Cousson <b-cousson@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Signed-off-by: Kevin Hilman <khilman@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
