From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Jan 2018 09:53:15 +0100
Subject: [PATCH 02/67] alpha: mark jensen as broken
In-Reply-To: <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
References: <20171229081911.2802-1-hch@lst.de>
 <20171229081911.2802-3-hch@lst.de>
 <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
Message-ID: <20180104085315.GD3251@lst.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 02, 2018 at 11:36:00AM +0100, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> > CONFIG_ALPHA_JENSEN has failed to compile since commit aca05038
> > ("alpha/dma: use common noop dma ops"), so mark it as broken.
> 
> unknown revision or path not in the working tree.
> Ah, you dropped the leading "6":
> 6aca0503847f6329460b15b3ab2b0e30bb752793
> is less than 2 years old, though.

I'll fix the reference.

But 23 month of a whole sub-architecture not compiling should still be
enough to mark it broken.
