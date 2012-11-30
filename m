From: vkoul@infradead.org (Vinod Koul)
Date: Sat, 01 Dec 2012 00:17:34 +0530
Subject: [PATCH] DMAEngine: add dmaengine_prep_interleaved_dma wrapper
 for interleaved api
In-Reply-To: <CAGsJ_4xWf+0-Zc0EWPva1tzq74NsT8KC+1SYArZNpBC05PC1+w@mail.gmail.com>
References: <1352209637-8841-1-git-send-email-21cnbao@gmail.com>
 <CAGsJ_4xWf+0-Zc0EWPva1tzq74NsT8KC+1SYArZNpBC05PC1+w@mail.gmail.com>
Message-ID: <1354301254.7077.79.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2012-11-07 at 20:49 +0800, Barry Song wrote:
> > From: Barry Song <Baohua.Song@csr.com>
> >
> > commit b14dab792dee(DMAEngine: Define interleaved transfer request
> api) adds
> > interleaved request api, this patch adds the
> dmaengine_prep_interleaved_dma
> > just like we have dmaengine_prep_ for other modes to avoid drivers
> call:
> > xxx_chan->device->device_prep_interleaved_dma().
> >
> > Signed-off-by: Barry Song <Baohua.Song@csr.com>
> > Cc: Jassi Brar <jaswinder.singh@linaro.org> 
Sounds good, Applied thanks

-- 
Vinod Koul
Intel Corp.
