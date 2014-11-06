From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 6 Nov 2014 11:36:53 +0530
Subject: [PATCH 00/11] dmaengine: Cleanup chancnt
In-Reply-To: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1413450063-23829-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20141106060653.GT1870@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 11:00:52AM +0200, Maxime Ripard wrote:
> Hi everyone,
> 
> As pointed out in the documentation thread [1], the chancnt variable
> is filled during the driver registration in dma_async_device_register,
> from the liste of channels that has been set.
> 
> This serie removes the occurences of the drivers that set it in their
> probe function.

Applied all, thanks

-- 
~Vinod
