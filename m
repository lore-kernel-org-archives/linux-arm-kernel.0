From: olof@lixom.net (Olof Johansson)
Date: Wed, 7 Dec 2011 16:21:18 -0800
Subject: [PATCH 4/5] arm/dt: tegra: Fix serial nodes to match board files
In-Reply-To: <1321911851-10091-4-git-send-email-swarren@nvidia.com>
References: <1321911851-10091-1-git-send-email-swarren@nvidia.com>
 <1321911851-10091-4-git-send-email-swarren@nvidia.com>
Message-ID: <20111208002118.GJ12945@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2011 at 02:44:10PM -0700, Stephen Warren wrote:
> Mark any serial ports that aren't registered by the board files as disabled
> in the device-tree files.
> 
> In practice, none of the now-disabled ports ended up succeeding device
> probing because of the missing clock-frequency property. However,
> explicitly marking the devices disabled has the advantage of squashing
> the dev_warn() the failed probe causes, and documenting that we intend
> the port not to be used, rather than accidentally left out the property.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.3/boards


-Olof
