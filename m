From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 13 Jun 2014 15:17:39 +0200
Subject: [PATCH v3 1/2] drm/panel: consolidate unnecessary explicit
 dependencies
In-Reply-To: <E1WvRBL-0007qq-2D@rmk-PC.arm.linux.org.uk>
References: <E1WvRBL-0007qq-2D@rmk-PC.arm.linux.org.uk>
Message-ID: <20140613131738.GA5568@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 02:06:11PM +0100, Russell King wrote:
> DRM_PANEL_LD9040 and DRM_PANEL_S6E8AA0 both explicitly depended on
> DRM_PANEL && DRM, whereas DRM_PANEL_SIMPLE relies upon the dependency
> on the menu.
> 
> We do not need to use explicit dependencies if we make the menu depend
> on DRM_PANEL && DRM - this will implicitly make each entry in the menu
> depend on DRM_PANEL && DRM without this needing to be explicitly stated
> against every entry.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  drivers/gpu/drm/panel/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied, thanks.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140613/c9420170/attachment-0001.sig>
