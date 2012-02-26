From: olof@lixom.net (Olof Johansson)
Date: Sun, 26 Feb 2012 14:17:32 -0800
Subject: [PATCH] ARM: tegra: Demote EMC clock inconsistency BUG to WARN
In-Reply-To: <1328576955-6295-1-git-send-email-swarren@nvidia.com>
References: <1328576955-6295-1-git-send-email-swarren@nvidia.com>
Message-ID: <20120226221732.GF11189@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2012 at 05:09:15PM -0800, Stephen Warren wrote:
> When this inconsistency occurs, the system will typically operate without
> issue, it's just that EMC scaling won't optimally. Convert the BUG_ON to
> a WARN_ONCE in order to allow the kernel to boot, but still complain.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Thanks, applied to for-3.4/soc.

-Olof
