From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 4 Jan 2016 09:26:45 +0100
Subject: [PATCH 2/3] drm: arm-hdlcd: remove COMMON_CLK_SCPI select
In-Reply-To: <3381082.HCMeGm07UJ@wuerfel>
References: <4194408.X82ccDjh5X@wuerfel>
 <3381082.HCMeGm07UJ@wuerfel>
Message-ID: <20160104082645.GD23797@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 01, 2016 at 03:38:53PM +0100, Arnd Bergmann wrote:
> The hdlcd driver has no build-time dependency on the SCPI clock
> and the bogus 'select' causes a warning when SCPI is disabled:
> 
> warning: (DRM_HDLCD) selects COMMON_CLK_SCPI which has unmet direct dependencies (COMMON_CLK && (ARM_SCPI_PROTOCOL || COMPILE_TEST))
> 
> This removes the select statement.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Found two more bugs in the same driver, so this is now a patch series

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/109467e9/attachment.sig>
