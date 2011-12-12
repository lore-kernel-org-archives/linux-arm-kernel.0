From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 12 Dec 2011 18:56:44 +0800
Subject: [PATCH 0/7] arm/imx6: add imx6q sabrelite board and imx6q
 cpufreq support
In-Reply-To: <20111212055600.GC16350@b20223-02.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <20111212054813.GE9572@S2100-06.ap.freescale.net>
 <20111212055600.GC16350@b20223-02.ap.freescale.net>
Message-ID: <20111212105643.GB16835@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 01:56:01PM +0800, Richard Zhao wrote:
> On Mon, Dec 12, 2011 at 01:48:14PM +0800, Shawn Guo wrote:
> > On Mon, Dec 12, 2011 at 11:42:25AM +0800, Richard Zhao wrote:
> > > - add imx6q sabrelite board support
> > > - add imx6q cpufreq support
> > > 
> > It seems that Rob Lee is also working on imx6q cpufreq.  We had some
> > talk about this.  I would suggest move the existing imx cpufreq driver
> > into drivers/cpufreq before we start adding imx6q support.  (Samsung
> > and Omap have already done that.)
> yes. There might be duplicate work here.
> I agree the migration. Please continue review other parts.
Sascha,

About cpufreq, this patch series aim to add imx6 cpufreq support. Migrating to
driver/cpufreq/ can leave to other coming patch. Is it ok for you?

Thanks
Richard
