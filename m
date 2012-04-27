From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 27 Apr 2012 20:36:52 +0800
Subject: [PATCH 08/17] ARM: msm: use machine specific hook for late init
In-Reply-To: <20120426174124.GA22248@codeaurora.org>
References: <1335454725-13089-1-git-send-email-shawn.guo@linaro.org>
 <1335454725-13089-9-git-send-email-shawn.guo@linaro.org>
 <20120426174124.GA22248@codeaurora.org>
Message-ID: <20120427123649.GX2234@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 10:41:24AM -0700, David Brown wrote:
> This should be ok.  I'll forward it on to Saravana Kannan and Stephen
> Boyd, since it will affect the clock changes they are working on, but
> It's not too difficult to adapt.
> 
I will drop the change on clock code, since common clk migration will
kill that late_initcall anyway, so that we can save the conflict.

Regards,
Shawn
