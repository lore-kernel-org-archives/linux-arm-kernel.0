From: wsa@the-dreams.de (Wolfram Sang)
Date: Mon, 22 Sep 2014 12:00:34 +0200
Subject: [PATCH v5 06/11] i2c: core: Convert to
 dev_pm_domain_attach|detach()
In-Reply-To: <20140922095253.GO1786@lahna.fi.intel.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
 <1411151264-16245-7-git-send-email-ulf.hansson@linaro.org>
 <20140920122318.GC3850@katana>
 <20140922095253.GO1786@lahna.fi.intel.com>
Message-ID: <20140922100033.GC1406@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 22, 2014 at 12:52:53PM +0300, Mika Westerberg wrote:
> On Sat, Sep 20, 2014 at 02:23:19PM +0200, Wolfram Sang wrote:
> > On Fri, Sep 19, 2014 at 08:27:39PM +0200, Ulf Hansson wrote:
> > > Previously only the ACPI PM domain was supported by the i2c bus.
> > > 
> > > Let's convert to the common attach/detach functions for PM domains,
> > > which currently means we are extending the support to include the
> > > generic PM domain as well.
> > > 
> > > Cc: linux-i2c at vger.kernel.org
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Reviewed-by: Kevin Hilman <khilman@linaro.org>
> > 
> > Looks good to me, but I'd like to give Mika a chance to look at it,
> > since he does ACPI with I2C. Adding to CC.
> 
> Looks fine to me.

Thanks! So:

Acked-by: Wolfram Sang <wsa@the-dreams.de>

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140922/c53378d3/attachment.sig>
