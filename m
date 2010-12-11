From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 10 Dec 2010 17:34:15 -0700 (MST)
Subject: [PATCH v2 4/8] OMAP4: clock data: Add missing fields in
	iva_hsd_byp_clk_mux_ck
In-Reply-To: <1291932820-11163-5-git-send-email-b-cousson@ti.com>
References: <1291932820-11163-1-git-send-email-b-cousson@ti.com>
	<1291932820-11163-5-git-send-email-b-cousson@ti.com>
Message-ID: <alpine.DEB.2.00.1012101732320.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 9 Dec 2010, Benoit Cousson wrote:

> From: Jonathan Bergsagel <jbergsagel@ti.com>
> 
> Add register address, mask and link to the clksel structure that
> were missing in the IVA DPLL mux clock node.
> 
> Signed-off-by: Jonathan Bergsagel <jbergsagel@ti.com>
> Signed-off-by: Benoit Cousson <b-cousson@ti.com>

This patch results in a checkpatch warning:

---

WARNING: please, no space before tabs
#23: FILE: arch/arm/mach-omap2/clock44xx_data.c:639:
+^I.clksel ^I= iva_hsd_byp_clk_mux_sel,$

total: 0 errors, 1 warnings, 0 checks, 13 lines checked

Your patch has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.

---

I've fixed it in the copy in my local branch, but next time, please run 
checkpatch.pl and fix any problems before submitting.

regards,

- Paul
