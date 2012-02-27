From: timur@freescale.com (Timur Tabi)
Date: Mon, 27 Feb 2012 14:28:43 -0600
Subject: [PATCH 0/6] ASoC: a few cleanups on sound/soc/fsl
In-Reply-To: <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
References: <1329979644-31046-1-git-send-email-shawn.guo@linaro.org>
 <1330092582-21180-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F4BE77B.2040802@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo wrote:
> This is the third series towards reusing fsl_ssi driver on device tree
> based IMX platforms.  It makes a few cleanups on existing PowerPC code
> to ease the later addition of an IMX machine driver that works on
> fsl_ssi.

These patches don't apply 100% cleanly, and there are some issues that
need to be resolved, but I'll review each one and ACK those that I think
are okay.  It would probably be better if none were applied until the
whole patchset is okay, though.

-- 
Timur Tabi
Linux kernel developer at Freescale
