From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 3 Mar 2016 21:07:02 +0530
Subject: [PATCH v2] dmaengine: pxa_dma: fix cyclic transfers
In-Reply-To: <1455659642-7746-1-git-send-email-robert.jarzmik@free.fr>
References: <1455659642-7746-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20160303153702.GO11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 16, 2016 at 10:54:02PM +0100, Robert Jarzmik wrote:
> While testing audio with pxa2xx-ac97, underrun were happening while the
> user application was correctly feeding the music. Debug proved that the
> cyclic transfer is not cyclic, ie. the last descriptor did not loop on
> the first.
> 
> Another issue is that the descriptor length was always set to 8192,
> because of an trivial operator issue.
> 
> This was tested on a pxa27x platform.

Applied, thanks

-- 
~Vinod
