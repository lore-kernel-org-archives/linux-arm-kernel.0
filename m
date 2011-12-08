From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:20:31 -0800
Subject: [PATCH 3/5] arm/dt: tegra: Fix I2C nodes to match board files
In-Reply-To: <1321911851-10091-3-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <1321911851-10091-3-git-send-email-swarren@nvidia.com>
Message-ID: <20111208002031.GI12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:44:09PM -0700, Stephen Warren wrote:
> With board files, all I2C busses run at 400KHz. Fix the device-tree
> to be consistent with this. It's possible this is incorrect, but at
> least it keeps the board files and device-tree consistent.
> 
> Also, disable any I2C controllers that the board files don't register,
> also for consistency.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/boards

-Olof
