From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 5 Aug 2015 11:00:28 +0530
Subject: [PATCH 0/2] dmaengine: Add scatter-gathered memset support
In-Reply-To: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1436177964-19380-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150805053028.GP11789@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 06, 2015 at 12:19:22PM +0200, Maxime Ripard wrote:
> Hi Vinod,
> 
> Here is a patch serie that adds a new dmaengine operation for
> scatter-gathered memset.
> 
> Indeed, doing a memset over a discontiguous buffer is quite
> inefficient at the moment, since you have to create and submit each
> chunk separately, which might result in a huge list of transfers,
> while some controllers can handle that just fine.

Applied, thanks

-- 
~Vinod
