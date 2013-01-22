From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 22 Jan 2013 04:29:39 +0100
Subject: [PATCH 06/14] mfd: omap-usb-host: update nports in platform_data
In-Reply-To: <1357836694-30788-7-git-send-email-rogerq@ti.com>
References: <1357836694-30788-1-git-send-email-rogerq@ti.com>
 <1357836694-30788-7-git-send-email-rogerq@ti.com>
Message-ID: <20130122032939.GS7409@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roger,

On Thu, Jan 10, 2013 at 06:51:26PM +0200, Roger Quadros wrote:
> EHCI driver would need to know the number of ports available
> on the platform. We set the nports parameter of platform_data
> based on IP version if it was not already provided.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
