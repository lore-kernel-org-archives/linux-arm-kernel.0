From: jrnieder@gmail.com (Jonathan Nieder)
Date: Mon, 10 Dec 2012 06:46:36 -0800
Subject: [PATCH] ARM: decompressor: include CONFIG_DEBUG_LL_INCLUDE
 rather than mach/debug-macro.S
In-Reply-To: <20121210140250.GL14363@n2100.arm.linux.org.uk>
References: <1355104168-30581-1-git-send-email-shawn.guo@linaro.org>
 <20121210015916.GA30766@S2101-09.ap.freescale.net>
 <20121210140250.GL14363@n2100.arm.linux.org.uk>
Message-ID: <20121210144350.GA3373@elie.Belkin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:

> That worries me a bit because I can see this ending up getting applied to
> multiple stable kernel trees, even those without CONFIG_DEBUG_LL_INCLUDE.
> So, let's have it in the patch system without the stable tag.

If it should only be included in 3.7-stable, a line like
"Cc: stable at vger.kernel.org # 3.7+" would work fine.

Hope that helps,
Jonathan
