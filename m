From: vinod.koul@intel.com (Vinod Koul)
Date: Tue, 13 Jan 2015 21:28:28 +0530
Subject: [PATCH 06/28] dma: drop owner assignment from platform_drivers
In-Reply-To: <20141231102350.GB1461@katana>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-7-git-send-email-wsa@the-dreams.de>
 <20141222153822.GP16827@intel.com> <20141231102350.GB1461@katana>
Message-ID: <20150113155828.GB14630@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 31, 2014 at 11:23:50AM +0100, Wolfram Sang wrote:
> On Mon, Dec 22, 2014 at 09:08:22PM +0530, Vinod Koul wrote:
> > On Sun, Dec 21, 2014 at 10:14:27PM +0100, Wolfram Sang wrote:
> > > This platform_driver does not need to set an owner, it will be populated by the
> > > driver core.
> > > 
> > After susbstem name if fixed
> > 
> > Acked-by: Vinod Koul <vinod.koul@intel.com>
> 
> Since I'd prefer this to go via your tree, can you fix it or shall I
> resend?
Sorry I don't have this patch, would you mind resending

-- 
~Vinod
