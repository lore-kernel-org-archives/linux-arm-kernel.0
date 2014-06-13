From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Jun 2014 14:06:49 +0100
Subject: [PATCH v2 1/2] drm/panel: remove unnecessary dependencies
In-Reply-To: <539A9225.90304@samsung.com>
References: <E1Wv7ZP-0004Wb-3J@rmk-PC.arm.linux.org.uk>
 <539A9225.90304@samsung.com>
Message-ID: <20140613130648.GR23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 07:54:45AM +0200, Andrzej Hajda wrote:
> Hi Russel,
> 
> Thanks for both fixes. Just one nitpick.
> 
> On 06/12/2014 06:09 PM, Russell King wrote:
> > DRM_PANEL_LD9040 and DRM_PANEL_S6E8AA0 both explicitly depended on
> > DRM_PANEL && DRM.  This is nonsense for two reasons:
> > 
> > (a) DRM_PANEL already depends on DRM, so DRM_PANEL can not be enabled
> > without DRM first being enabled.  Hence the && DRM is useless.
> 
> This reason is invalid and do not describe the patch anymore.

Thanks, expect v3 in your mailbox shortly (or already there.)

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
