From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 19 Aug 2016 13:42:11 +0800
Subject: [PATCH v10 8/9] arm: dts: mt2701: Add clock controller device
 nodes
In-Reply-To: <20160819001805.GR361@codeaurora.org>
References: <1471332629-15722-1-git-send-email-erin.lo@mediatek.com>
 <1471332629-15722-9-git-send-email-erin.lo@mediatek.com>
 <20160819001805.GR361@codeaurora.org>
Message-ID: <1471585331.8551.24.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2016-08-18 at 17:18 -0700, Stephen Boyd wrote:
> On 08/16, Erin Lo wrote:
> > From: James Liao <jamesjj.liao@mediatek.com>
> > 
> > Add clock controller nodes for MT2701, include topckgen, infracfg,
> > pericfg, apmixedsys, mmsys, imgsys, vdecsys, hifsys, ethsys and
> > bdpsys. This patch also add two oscillators that provide clocks for
> > MT2701.
> > 
> > Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
> > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > ---
> 
> This should go through arm-soc tree, so do you need a stable
> branch in clk tree to pull through arm-soc, or are we going to
> wait a release cycle on the dts patches?

Hi Stephen,

I prefer to wait a release cycle. We may merge clk driver first, then
merge dts patches in next kernel release.


Best regards,

James
