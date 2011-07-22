From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 22 Jul 2011 00:16:06 -0600
Subject: [RFC/PATCH 6/7] OMAP: omap_device: device register functions now
	take platform_device pointer
In-Reply-To: <1311292338-11830-8-git-send-email-khilman@ti.com>
References: <1311292338-11830-1-git-send-email-khilman@ti.com>
	<1311292338-11830-8-git-send-email-khilman@ti.com>
Message-ID: <20110722061606.GA18383@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2011 at 04:52:17PM -0700, Kevin Hilman wrote:
> The internal device register functions do not need or use any omap_device
> internals, so pass in a platform_device pointer instead of an omap_device
> pointer.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>

FWIW, all 6 of these cleanups look sane.

Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
