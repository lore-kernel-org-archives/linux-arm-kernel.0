From: vinod.koul@intel.com (Vinod Koul)
Date: Fri, 12 Jun 2015 18:14:13 +0530
Subject: [PATCH 0/2] dmaengine: hdmac: Implement interleaved transfers
 support
In-Reply-To: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150612124413.GH28601@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 04:01:51PM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> This patchset implements the interleaved transfer capability found on
> some AT91 SoCs.
> 
> The hardware actually support a somewhat similar mode called
> picture-in-picture, that allows to transfer a squared portion of a
> framebuffer.
> 
> That actually means that the interleaved transfer that this hardware
> support will need to have the same size and ICGs across all its
> chunks.
> 
> It has been tested on the SAMA5D36.

Applied, thanks

-- 
~Vinod
