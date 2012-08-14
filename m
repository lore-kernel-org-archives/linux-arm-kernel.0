From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 14 Aug 2012 09:26:51 +0800
Subject: [PATCH 1/2] ARM: mach-imx: Remove board entries in dt_board_compat
In-Reply-To: <5029761B.9080502@gmail.com>
References: <1339941856-2836-1-git-send-email-festevam@gmail.com>
 <20120705071318.GO30009@pengutronix.de>
 <20120705074623.GG10610@S2101-09.ap.freescale.net>
 <20120813151509.GB27393@S2101-09.ap.freescale.net>
 <5029761B.9080502@gmail.com>
Message-ID: <20120814012649.GA27792@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 13, 2012 at 04:48:11PM -0500, Rob Herring wrote:
> I think this is needless churn. You can't say board entries are never
> needed. Perhaps we've been overly active in adding all compatible
> strings before they are needed. When you add a new board, it is fine to
> match against the soc string without changing the kernel, but the dtb
> should still have a more specific string. Then if you need to add
> something board specific later, you can add the match entry and
> corresponding board specific code.
> 
I probably haven't made myself clear.  What I'm asking for is merely
removing the board compatible string from dt_board_compat, not from
dtb.  Every single board will still have its specific compatible string
defined in its dts.

-- 
Regards,
Shawn
