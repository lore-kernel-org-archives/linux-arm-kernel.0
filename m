From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:08:13 +0300
Subject: [PATCH v2 3/5] video: exynos_mipi_dsim: Use generic PHY driver
In-Reply-To: <1372170110-12993-3-git-send-email-s.nawrocki@samsung.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <1372170110-12993-3-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130625150813.GB21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 25, 2013 at 04:21:48PM +0200, Sylwester Nawrocki wrote:
> Use the generic PHY API instead of the platform callback to control
> the MIPI DSIM DPHY. The 'phy_label' field is added to the platform
> data structure to allow PHY lookup on non-dt platforms.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

this is awesome :-)

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/b4580dab/attachment.sig>
