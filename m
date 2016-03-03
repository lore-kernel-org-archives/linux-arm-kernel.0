From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Mar 2016 21:17:35 +0530
Subject: [PATCH 2/3] dmaengine: sun4i: support module autoloading
In-Reply-To: <1456104396-13282-2-git-send-email-emilio@elopez.com.ar>
References: <1456104396-13282-1-git-send-email-emilio@elopez.com.ar>
 <1456104396-13282-2-git-send-email-emilio@elopez.com.ar>
Message-ID: <20160303154735.GR11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 21, 2016 at 10:26:35PM -0300, Emilio L?pez wrote:
> From: Emilio L?pez <emilio.lopez@collabora.co.uk>
> 
> MODULE_DEVICE_TABLE() is missing, so the module isn't auto-loading on
> supported systems. This commit adds the missing line so it loads
> automatically when building it as a module and running on a system
> with the early sunxi DMA engine.

Applied, thanks

-- 
~Vinod
