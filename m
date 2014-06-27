From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 27 Jun 2014 16:34:05 +0100
Subject: [PATCH v3 2/4] drm: Constify struct drm_fb_helper_funcs
In-Reply-To: <1403882365-18337-2-git-send-email-thierry.reding@gmail.com>
References: <1403882365-18337-1-git-send-email-thierry.reding@gmail.com>
 <1403882365-18337-2-git-send-email-thierry.reding@gmail.com>
Message-ID: <20140627153405.GM32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 05:19:23PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> There's no need for this to be modifiable. Make it const so that it can
> be put into the .rodata section.
> 
> Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Definitely a good thing.  For Armada:

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
