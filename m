From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Mar 2012 22:18:14 +0800
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <20120320094031.GI3852@pengutronix.de>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
 <20120320094031.GI3852@pengutronix.de>
Message-ID: <20120320141811.GF32469@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 10:40:31AM +0100, Sascha Hauer wrote:
...
> I am using these functions and don't need a static array, I just call
> the functions with the desired parameters.
> 
With this patch getting in, you do not have to use them then.  I feel
a static array will be much more readable than a long list of function
calls with a long list of hardcoded arguments to each.

-- 
Regards,
Shawn
