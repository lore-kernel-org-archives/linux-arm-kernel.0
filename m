From: hs.liao@mediatek.com (Horng-Shyang Liao)
Date: Fri, 30 Sep 2016 16:56:06 +0800
Subject: [PATCH v14 4/4] CMDQ: save more energy in idle
In-Reply-To: <1474622885.21723.25.camel@mtksdaap41>
References: <1473039885-24009-1-git-send-email-hs.liao@mediatek.com>
 <1473039885-24009-5-git-send-email-hs.liao@mediatek.com>
 <CABb+yY1YqyReK5bii6n5a_rJ6fgpPi=aC3sfKJdomvM5+NG9FA@mail.gmail.com>
 <1474622885.21723.25.camel@mtksdaap41>
Message-ID: <1475225766.25044.33.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2016-09-23 at 17:28 +0800, Horng-Shyang Liao wrote:
> On Thu, 2016-09-22 at 13:22 +0530, Jassi Brar wrote:
> > On Mon, Sep 5, 2016 at 7:14 AM, HS Liao <hs.liao@mediatek.com> wrote:
> > > Use clk_disable_unprepare instead of clk_disable to save more energy
> > > when CMDQ is idle.
> > >
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > ---
> > >  drivers/mailbox/mtk-cmdq.c | 54 +++++++++++++++++++++++++++++++++++++++-------
> > 
> > The driver is introduced by second patch of the set, so it makes sense
> > to merge this patch into patch 2/4.
> 
> Hi Jassi,
> 
> Could you take a look at previous discussion between Matthias and me?
> http://lkml.iu.edu/hypermail/linux/kernel/1606.2/05239.html
> His basic idea is to simplify first working version.
> Therefore, I move some code to this patch.
> 
> Thanks,
> HS
> 

Hi Jassi,

What do you think about our previous discussion?

Thanks,
HS
