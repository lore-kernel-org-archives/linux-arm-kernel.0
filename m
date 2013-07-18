From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 14:04:44 -0700
Subject: [PATCH v3 0/5] clk: dt: bindings for mux, divider & gate clocks
In-Reply-To: <1371795256-16703-1-git-send-email-mturquette@linaro.org>
References: <1371795256-16703-1-git-send-email-mturquette@linaro.org>
Message-ID: <51E8586C.7040808@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/20/13 23:14, Mike Turquette wrote:
> This series introduces binding definitions for common register-mapped
> clock multiplexer, divider and gate IP blocks along with the
> corresponding setup functions for matching DT data.  The bindings are
> similar to the struct definitions but please don't hold that against the
> binding: the struct definitions closely model the hardware register
> layout.

I know there was some discussion about clock bindings and how they
should and should not be done at Linaro Connect Europe last week. Can
someone in that discussion reply to the mailing list with what came out
of that? I only have second hand knowledge about the discussion so it
would be good for me and others to know what was discussed. I'm
especially curious because the arm soc update etherpad[1] says "DT
describes what HW is (location, type, attributes), not how HW works
(register descriptions, bitmasks, etc)." but these proposed generic
clock bindings are describing registers and bitmasks.

[1] http://pad.linaro.org/p/LCE13_ARM_SOC_Tree_Consolidation_Update

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
