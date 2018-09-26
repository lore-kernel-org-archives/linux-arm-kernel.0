From: ryder.lee@mediatek.com (Ryder Lee)
Date: Wed, 26 Sep 2018 10:51:30 +0800
Subject: [Resend PATCH 5/5] arm: dts: mt7623: add display subsystem
 related device nodes
In-Reply-To: <aef1f507-b217-5587-d058-fb0b08698cd1@gmail.com>
References: <84011aa94dd7be9239b7a2f944dd30fc70568fbb.1536155449.git.ryder.lee@mediatek.com>
 <7105c341de3525761ad4067ca57c641c7097f773.1536155449.git.ryder.lee@mediatek.com>
 <aef1f507-b217-5587-d058-fb0b08698cd1@gmail.com>
Message-ID: <1537930290.881.2.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-09-25 at 17:48 +0200, Matthias Brugger wrote:
> 
> On 05/09/2018 16:09, Ryder Lee wrote:
> > Add display subsystem related device nodes for MT7623.
> > 
> > Cc: CK Hu <ck.hu@mediatek.com>
> > Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> > Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>
> > Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> > ---
> > I forgot to sort nodes in my previous mail. Sorry for the inconvenience.
> > 
> > This patch depends on the series: https://lkml.org/lkml/2018/9/5/223
> 
> That's not yet merged, right?

Yes.

> > 
> > @Matthias,
> > I know you're working on broken MMSYS - just want to ask whether it's possible
> > to let the patch to go to your tree (if others are okay with it), and send a
> > fixup one for MT7623 MMSYS later?
> 
> I know I'm a big blocker here, sorry for the inconvenience.
> I'll do my best to get that in for the next release. If I make no progress on
> that then we should find a different solution.

No problem. Thanks for your great effort :)

> Regards,
> Matthias
> 
> > ---
> >  arch/arm/boot/dts/mt7623.dtsi                 | 177 ++++++++++++++++++++++++++
> >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts |  83 ++++++++++++
> >  arch/arm/boot/dts/mt7623n-rfb-emmc.dts        |  83 ++++++++++++
> >  3 files changed, 343 insertions(+)
