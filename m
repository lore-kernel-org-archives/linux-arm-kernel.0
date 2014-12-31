From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 31 Dec 2014 11:23:50 +0100
Subject: [PATCH 06/28] dma: drop owner assignment from platform_drivers
In-Reply-To: <20141222153822.GP16827@intel.com>
References: <1419196495-9626-1-git-send-email-wsa@the-dreams.de>
 <1419196495-9626-7-git-send-email-wsa@the-dreams.de>
 <20141222153822.GP16827@intel.com>
Message-ID: <20141231102350.GB1461@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 22, 2014 at 09:08:22PM +0530, Vinod Koul wrote:
> On Sun, Dec 21, 2014 at 10:14:27PM +0100, Wolfram Sang wrote:
> > This platform_driver does not need to set an owner, it will be populated by the
> > driver core.
> > 
> After susbstem name if fixed
> 
> Acked-by: Vinod Koul <vinod.koul@intel.com>

Since I'd prefer this to go via your tree, can you fix it or shall I
resend?
