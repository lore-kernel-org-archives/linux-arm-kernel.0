From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 20 Aug 2012 09:56:12 +0200
Subject: [PATCH 1/8] arm: sam9_l9260_defconfig: adjust UBI bad
 eraseblocks limit
In-Reply-To: <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
References: <1345214124-5478-1-git-send-email-richard.genoud@gmail.com>
 <1345214124-5478-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20120820075612.GD7439@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:35 Fri 17 Aug     , Richard Genoud wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> 
> UBI has changed the MTD_UBI_BEB_LIMIT semantics. It used to be a percent of
> total amount of eraseblock in the partition, and now it is the maximum
> amount of bad eraseblocks on the entire devise per 1024 eraseblocks. So not
> only the units changed, but also the meaning. But anyway, old 3% roughly
> correspond to new 30, so change the defconfig correspondingly.
> 
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
simply drop this defconfig

Best Regards,
J.
