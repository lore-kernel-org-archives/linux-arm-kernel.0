From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:09:08 +0300
Subject: [PATCH v2 4/5] exynos4-is: Use generic MIPI CSIS PHY driver
In-Reply-To: <1372170110-12993-4-git-send-email-s.nawrocki@samsung.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <1372170110-12993-4-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130625150908.GC21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 04:21:49PM +0200, Sylwester Nawrocki wrote:
> Use the generic PHY API instead of the platform callback to control
> the MIPI CSIS DPHY. The 'phy_label' field is added to the platform
> data structure to allow PHY lookup on non-dt platforms
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/dea5d630/attachment.sig>
