From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 26 Jun 2013 12:10:30 +0200
Subject: [PATCH 03/23] ARM: dt: tegra30: iommu: Add "nvidia,memory-clients"
In-Reply-To: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
References: <1372238906-9346-4-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130626101028.GD27083@manwe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 26, 2013 at 12:28:06PM +0300, Hiroshi Doyu wrote:
> Add "nvidia,memory-clients" to identify which swgroup ID a device
> belongs to.

Why not call the property "nvidia,swgid" instead? That seems a lot more
intuitive.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130626/635ee5df/attachment-0001.sig>
