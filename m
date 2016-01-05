From: jamesjj.liao@mediatek.com (James Liao)
Date: Tue, 5 Jan 2016 18:00:13 +0800
Subject: [PATCH v2 5/6] reset: mediatek: mt2701 reset controller
 dt-binding file
In-Reply-To: <1451986291.3391.5.camel@pengutronix.de>
References: <1451975422-31174-1-git-send-email-jamesjj.liao@mediatek.com>
 <1451975422-31174-6-git-send-email-jamesjj.liao@mediatek.com>
 <1451986291.3391.5.camel@pengutronix.de>
Message-ID: <1451988013.19662.2.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, 2016-01-05 at 10:31 +0100, Philipp Zabel wrote:
> Am Dienstag, den 05.01.2016, 14:30 +0800 schrieb James Liao:
> > From: Shunli Wang <shunli.wang@mediatek.com>
> > 
> > Dt-binding file about reset controller is used to provide
> > kinds of definition, which is referenced by dts file and
> > IC-specified reset controller driver code.
> > 
> > Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
> > ---
> >  .../dt-bindings/reset-controller/mt2701-resets.h   | 74 ++++++++++++++++++++++
> >  1 file changed, 74 insertions(+)
> >  create mode 100644 include/dt-bindings/reset-controller/mt2701-resets.h
> > 
> > diff --git a/include/dt-bindings/reset-controller/mt2701-resets.h b/include/dt-bindings/reset-controller/mt2701-resets.h
> 
> No new files in include/dt-bindings/reset-controller, please.
> This should go into include/dt-bindings/reset.

OK, I'll move it to include/dt-bindings/reset/.


Best regards,

James
