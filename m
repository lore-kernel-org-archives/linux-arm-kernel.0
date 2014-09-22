From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Mon, 22 Sep 2014 12:52:53 +0300
Subject: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
In-Reply-To: <20140920122318.GC3850@katana>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
 <20140920122318.GC3850@katana>
Message-ID: <20140922095253.GO1786@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 20, 2014 at 02:23:19PM +0200, Wolfram Sang wrote:
> On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> > Previously only the ACPI PM domain was supported by the i2c bus.
> > 
> > Let's convert to the common attach/detach functions for PM domains,
> > which currently means we are extending the support to include the
> > generic PM domain as well.
> > 
> > Cc: linux-i2c at vger.kernel.org
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Looks good to me, but I'd like to give Mika a chance to look at it,
> since he does ACPI with I2C. Adding to CC.

Looks fine to me.
