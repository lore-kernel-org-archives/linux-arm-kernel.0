From: richard.zhao@freescale.com (Richard Zhao)
Date: Mon, 12 Dec 2011 13:56:01 +0800
Subject: [PATCH 0/7] arm/imx6: add imx6q sabrelite board and imx6q
 cpufreq support
In-Reply-To: <20111212054813.GE9572@S2100-06.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <20111212054813.GE9572@S2100-06.ap.freescale.net>
Message-ID: <20111212055600.GC16350@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 01:48:14PM +0800, Shawn Guo wrote:
> On Mon, Dec 12, 2011 at 11:42:25AM +0800, Richard Zhao wrote:
> > - add imx6q sabrelite board support
> > - add imx6q cpufreq support
> > 
> It seems that Rob Lee is also working on imx6q cpufreq.  We had some
> talk about this.  I would suggest move the existing imx cpufreq driver
> into drivers/cpufreq before we start adding imx6q support.  (Samsung
> and Omap have already done that.)
yes. There might be duplicate work here.
I agree the migration. Please continue review other parts.

Rob,

Could you review this patch series too and check the fragment?


Thanks
Richard
> 
> -- 
> Regards,
> Shawn
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
