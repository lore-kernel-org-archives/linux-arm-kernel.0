From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 15:07:48 +0200
Subject: [PATCH v3 1/2] drm/panel: consolidate unnecessary explicit
 dependencies
In-Reply-To: <E1WvRBL-0007qq-2D@rmk-PC.arm.linux.org.uk>
References: <E1WvRBL-0007qq-2D@rmk-PC.arm.linux.org.uk>
Message-ID: <4454002.W4KMQyPspI@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 June 2014 14:06:11 Russell King wrote:
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
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
