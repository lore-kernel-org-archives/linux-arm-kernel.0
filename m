From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 10 Jul 2012 11:14:11 +0200
Subject: [PATCH V6 0/4] add 88pm80x mfd driver
In-Reply-To: <1341896853-29755-1-git-send-email-zhouqiao@marvell.com>
References: <1341896853-29755-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <20120710091411.GV15345@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Zhou,

On Tue, Jul 10, 2012 at 01:07:29PM +0800, Qiao Zhou wrote:
> change log [v6->v5]:
> export_symbol_gpl for pm80x_regmap_config to fix build issue for module.
I did already apply a patch from Axel Lin that fixes that build failure. See
commit 78a73e59db21b465fe60e795a0b7eadb0451370b from my for-next branch.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
