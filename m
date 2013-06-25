From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Jun 2013 18:09:58 +0300
Subject: [PATCH v2 5/5] ARM: Samsung: Remove MIPI PHY setup code
In-Reply-To: <1372170110-12993-5-git-send-email-s.nawrocki@samsung.com>
References: <1372170110-12993-1-git-send-email-s.nawrocki@samsung.com>
 <1372170110-12993-5-git-send-email-s.nawrocki@samsung.com>
Message-ID: <20130625150958.GD21334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 04:21:50PM +0200, Sylwester Nawrocki wrote:
> Generic PHY drivers are used to handle the MIPI CSIS and MIPI DSIM
> DPHYs so we can remove now unused code at arch/arm/plat-samsung.
> In case there is any board file for S5PV210 platforms using MIPI
> CSIS/DSIM (not any upstream currently) it should use the generic
> PHY API to bind the PHYs to respective PHY consumer drivers.
> 
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

pretty cool stuff

Acked-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130625/7ecc4d9b/attachment-0001.sig>
