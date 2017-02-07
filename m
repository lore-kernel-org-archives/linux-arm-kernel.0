From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 7 Feb 2017 13:33:59 +0100
Subject: [PATCH v2 6/7] drm/rockchip: Respect page offset in IOMMU mmap
In-Reply-To: <1486456749-19142-1-git-send-email-mark.yao@rock-chips.com>
References: <1486456542-18675-1-git-send-email-mark.yao@rock-chips.com>
 <1486456749-19142-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20170207123359.GB18315@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 07, 2017 at 04:39:09PM +0800, Mark Yao wrote:
> From: ?rjan Eide <orjan.eide@arm.com>
> 
> When mapping buffers through the PRIME DMA-buf mmap path we might be
> given an offset which has to be respected. The DRM GEM mmap path already
> takes care of zeroing out the fake mmap offset, so we can just make the
> IOMMU mmap implementation always respect the offset.
> 
> TEST=graphics_GLBench

This is useless in an upstream context, please remove.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/48ca8de4/attachment-0001.sig>
