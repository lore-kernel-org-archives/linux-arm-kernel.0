From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 May 2013 23:26:09 +0530
Subject: [PATCH 35/39] dmaengine: ste_dma40_ll: Replace meaningless
 register set with comment
In-Reply-To: <CACRpkdbXVd7k9rzb-OKUmnW_9J+jWYhz=AjO09_Ymvd2_DOVcQ@mail.gmail.com>
References: <1368611522-9984-1-git-send-email-lee.jones@linaro.org>
 <1368611522-9984-36-git-send-email-lee.jones@linaro.org>
 <CACRpkdbXVd7k9rzb-OKUmnW_9J+jWYhz=AjO09_Ymvd2_DOVcQ@mail.gmail.com>
Message-ID: <20130530175609.GF3767@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 11:04:23AM +0200, Linus Walleij wrote:
> On Wed, May 15, 2013 at 11:51 AM, Lee Jones <lee.jones@linaro.org> wrote:
> 
> > Unsure of the author's intentions, rather than just removing the nop,
> > we're replacing it with a comment containing the possible intention
> > of the statement OR:ing with 0.
> >
> > Cc: Vinod Koul <vinod.koul@intel.com>
> > Cc: Dan Williams <djbw@fb.com>
> > Cc: Per Forlin <per.forlin@stericsson.com>
> > Cc: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Tentatively applied. Missing Vinod's ACK.
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
