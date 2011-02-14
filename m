From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 14 Feb 2011 09:50:11 -0700 (MST)
Subject: [PATCH v2 3/7] omap: clock: Add allow_idle/deny_idle support in
	clkops
In-Reply-To: <ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
References: <1297329400-5936-1-git-send-email-rnayak@ti.com>
	<1297329400-5936-2-git-send-email-rnayak@ti.com>
	<1297329400-5936-3-git-send-email-rnayak@ti.com>
	<1297329400-5936-4-git-send-email-rnayak@ti.com>
	<alpine.DEB.2.00.1102121643250.21991@utopia.booyaka.com>
	<ab30a208ca55e9295e25b8c3495dfa31@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1102140949120.21991@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 14 Feb 2011, Rajendra Nayak wrote:

> A couple of issues on the clk_autoidle_a_2.6.39 branch:
> -1- There seems to be a missing fix which causes an abort
> at boot on omap4
> http://marc.info/?l=linux-omap&m=129768574027232&w=2

This should be fixed now that this branch is rebased on your first two 
clock patches.

> -2- There is a trivial fix (Patch below) needed which otherwise
> breaks build

Thanks for this, I've folded this fix into the original patch.


- Paul
