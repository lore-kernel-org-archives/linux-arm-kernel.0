From: olof@lixom.net (Olof Johansson)
Date: Mon, 19 Dec 2011 17:56:34 -0800
Subject: [PATCH V2 1/4] i2c: tegra: Add __devinit/exit to probe/remove
In-Reply-To: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
References: <1324189772-26914-1-git-send-email-swarren@nvidia.com>
Message-ID: <20111220015634.GA27789@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 17, 2011 at 11:29:29PM -0700, Stephen Warren wrote:
> This fixes some section mismatch build warnings.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Ben, since the patch is trivial, I've picked it up in tegra
for-3.3/drivers and will merge that way. Let me know if you disagree.


Thanks,

-Olof
