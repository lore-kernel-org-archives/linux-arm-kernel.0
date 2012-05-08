From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 9 May 2012 00:12:13 +0800
Subject: [PATCH 0/5] more clk-next fixes
In-Reply-To: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
References: <1336367310-5140-1-git-send-email-mturquette@linaro.org>
Message-ID: <20120508161211.GI2199@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 10:08:25PM -0700, Mike Turquette wrote:
> If no one complains about these then I'll commit them to clk-next and
> (finally) send my pull request to Arnd.
> 
On mach-mxs:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Mike,

I haven't seen too many outstanding comments on these patches, except
the following one that Saravana put on clk-fixed-factor.c, which should
be easy to fix.

"
> +     return (parent_rate / fix->div) * fix->mult;

Wouldn't multiplying and then dividing result in better accuracy?
"

Can you please quickly fix it and publish the patches on your clk-next,
so that I can ask Arnd to pull my platform porting, on which mach-mxs
device tree series depends.

-- 
Regards,
Shawn
