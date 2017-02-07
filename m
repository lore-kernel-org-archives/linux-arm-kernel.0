From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 7 Feb 2017 13:38:59 +0100
Subject: [PATCH v2 0/7] drm/rockchip: switch to drm_mm for support arm64
 iommu
In-Reply-To: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170207123859.GD18315@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 04:35:35PM +0800, Mark Yao wrote:
> Some iommu patches on the series[0] "iommu/rockchip: Fix bugs and
> enable on ARM64" already landed, So drm/rockchip related patches [1] and [2]
> ready to landed, this series just rebase them to lastest drm-next.
> 
> And fix some bugs for drm/rockchip drm_mm
> 
> [0]: http://www.spinics.net/lists/arm-kernel/msg513781.html
> [1]: https://patchwork.kernel.org/patch/9196367
> [2]: https://patchwork.kernel.org/patch/9196369
> 
> Changes in v2:
> Advices by Tomasz:
>   add some fixes patches from chromeos project.

I think those fixes should've been squashed into the patches that they
fix. It's very unusual to merge patches upstream that are know to have
been fixed already.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/20157287/attachment.sig>
