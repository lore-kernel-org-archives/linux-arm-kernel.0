From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 30 May 2013 23:03:26 +0530
Subject: [PATCH -next v2] dmaengine: ste_dma40: fix error return code
 in d40_probe()
In-Reply-To: <CACRpkdYBfvr0kA7bd-6Ns78UH7JtBCFDzFxyHLgtReB32O4D+w@mail.gmail.com>
References: <CAPgLHd-gjJ6ju3HyhiQi98YFGojvU3aYSTn7SOe4NhQPY1r++w@mail.gmail.com>
 <CACRpkdYBfvr0kA7bd-6Ns78UH7JtBCFDzFxyHLgtReB32O4D+w@mail.gmail.com>
Message-ID: <20130530173326.GD3767@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 30, 2013 at 09:41:38AM +0200, Linus Walleij wrote:
> On Thu, May 30, 2013 at 6:32 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> > In many of the error handling case, the return value 'ret' not set
> > and 0 will be return from d40_probe() even if error, but we should
> > return a negative error code instead in those error handling case.
> > This patch fixed them, and also removed useless variable 'err'.
> >
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > ---
> > v1 -> v2: rebased on linux-next.git
> 
> I've tentatively applied this to my dma40 branch, waiting for Vinod
> to ACK it.
I though you wanted me to apply this :)

Nevertheless, Acked-by: Vinod Koul <vinod.koul@intel.com>

Can you CC stable too, pls.

--
~Vinod

-- 
