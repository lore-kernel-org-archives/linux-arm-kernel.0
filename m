From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Jun 2014 18:07:54 +0200
Subject: [PATCH 1/2] drm/panel: remove unnecessary dependencies
In-Reply-To: <20140612160434.GL23430@n2100.arm.linux.org.uk>
References: <E1Wv7GZ-0004SJ-PO@rmk-PC.arm.linux.org.uk>
 <4955669.feOMdjBDuA@wuerfel> <20140612160434.GL23430@n2100.arm.linux.org.uk>
Message-ID: <4945348.dQ7KNHLPYX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 12 June 2014 17:04:34 Russell King - ARM Linux wrote:
> 
> In which case, that's a bug for DRM_PANEL_SIMPLE which uses the same
> mechanism.  Since everything is going to be in the same boat, the
> menu should depend on DRM && DRM_PANEL.
> 

Right, I actually have a patch for DRM_PANEL_SIMPLE in my randconfig
series that I haven't sent out. Making the menu depend on DRM
is probably correct, but I haven't tried.

	Arnd
