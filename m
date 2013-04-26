From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 26 Apr 2013 11:52:19 +0800
Subject: [PATCH v2] ARM: imx: replicate the diagnostic register of boot
 cpu into secondary cores
In-Reply-To: <20130425152152.GA25671@mudshark.cambridge.arm.com>
References: <1366903115-11195-1-git-send-email-shawn.guo@linaro.org>
 <20130425152152.GA25671@mudshark.cambridge.arm.com>
Message-ID: <20130426035217.GC7504@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 04:21:52PM +0100, Will Deacon wrote:
> I'm still against setting this register with the MMU enabled. It is a
> CPU-specific, undocumented register so it's hard for me to make a case here,
> but the feedback from the hardware guys is that this may have unintended
> consequences.

I see that Exynos cpuidle driver has been doing that since Mar last
year.  But I respect your comment and will try to set the register
before MMU is enabled.

Shawn
