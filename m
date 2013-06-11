From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 11 Jun 2013 09:41:50 +0100
Subject: [PATCH 0/2] MCPM backend for Virtual Express TC2
In-Reply-To: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
References: <1370587152-4630-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <1370940110.3393.2.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-06-07 at 02:39 -0400, Nicolas Pitre wrote:
> This is the MCPM backend enabling SMP secondary boot and CPU hotplug
> on the VExpress TC2 big.LITTLE platform.  The method to allow CPU suspend
> is also implemented.

Are we leaving out for now Lorenzo's patch "ARM: TC2: reset CPUs
spuriously woken up on cluster power up"?

I got reminded of this after reading the comments on Mark Rutland's
"[PATCH] arm: versatile: don't mark pen as __INIT"

-- 
Tixy
