From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 27 Jun 2013 09:15:31 +0800
Subject: [PATCH v4] thermal: add imx thermal driver support
In-Reply-To: <1372055444-5286-1-git-send-email-shawn.guo@linaro.org>
References: <1372055444-5286-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130627011529.GA3942@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 02:30:44PM +0800, Shawn Guo wrote:
> This is based on the initial imx thermal work done by
> Rob Lee <rob.lee@linaro.org> (Not sure if the email address is still
> valid).  Since he is no longer interested in the work and I have
> rewritten a significant amount of the code, I just took the authorship
> over from him.
> 
> It adds the imx thermal support using Temperature Monitor (TEMPMON)
> block found on some Freescale i.MX SoCs.  The driver uses syscon regmap
> interface to access TEMPMON control registers and calibration data, and
> supports cpufreq as the cooling device.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Rui,

Can this patch be applied for 3.11?

Shawn
