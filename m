From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 17 Jul 2015 12:05:47 +0200
Subject: [PATCH V3 05/19] memory: tegra: add flush operation for Tegra124
 memory clients
In-Reply-To: <1436791197-32358-6-git-send-email-jonathanh@nvidia.com>
References: <1436791197-32358-1-git-send-email-jonathanh@nvidia.com>
 <1436791197-32358-6-git-send-email-jonathanh@nvidia.com>
Message-ID: <20150717100546.GJ3057@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 01:39:43PM +0100, Jon Hunter wrote:
> From: Vince Hsu <vinceh@nvidia.com>
> 
> This patch adds the hot reset register table and flush related callback
> functions for Tegra124.
> 
> Signed-off-by: Vince Hsu <vinceh@nvidia.com>
> [jonathanh at nvidia.com: Removed tegra_mc_ops and added
>  metastable_flush_reads.]
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
>  drivers/memory/tegra/tegra124.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)

Same comments as for Tegra114.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150717/7bccb043/attachment.sig>
