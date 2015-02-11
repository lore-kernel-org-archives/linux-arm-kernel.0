From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 10 Feb 2015 16:14:28 -0800
Subject: [PATCH] dmaengine: pl330: fix bug that cause start the same
 descs in cyclic
In-Reply-To: <1418038100-4316-1-git-send-email-addy.ke@rock-chips.com>
References: <1418038100-4316-1-git-send-email-addy.ke@rock-chips.com>
Message-ID: <20150211001428.GA21387@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 07:28:20PM +0800, Addy Ke wrote:
> This bug will cause NULL pointer after commit dfac17, and cause
> wrong package in I2S DMA transfer before commit dfac17.
> 
Applied, thanks

-- 
~Vinod
