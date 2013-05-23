From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 23 May 2013 16:16:58 +0530
Subject: [PATCH 10/63] dmaengine: ste_dma40: Amalgamate DMA source and
 destination channel numbers
In-Reply-To: <CACRpkdai7y+LBiFyK+b-CvW6p7n+TbC1iX0+XiLyg2V_8rFL+A@mail.gmail.com>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-11-git-send-email-lee.jones@linaro.org>
 <CACRpkdai7y+LBiFyK+b-CvW6p7n+TbC1iX0+XiLyg2V_8rFL+A@mail.gmail.com>
Message-ID: <20130523104658.GF30200@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 20, 2013 at 02:35:01PM +0200, Linus Walleij wrote:
> On Fri, May 3, 2013 at 4:31 PM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Devices which utilise DMA use the same device numbers for transmitting
> > and receiving. In this patch we encode the source and destination
> > information into one single attribute. We can subsequently exploit the
> > direction attribute to see which of the transfer directions are being
> > described. This also lessens the burden on platform data.
> >
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Acked-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Still waiting for an ACK from Vinod on this as well.
Here you go...

Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> 
> Vinod?
> 
> Yours,
> Linus Walleij
