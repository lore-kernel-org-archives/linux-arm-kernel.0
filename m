From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 1 Sep 2016 14:47:46 +0200
Subject: [PATCH v9 3/4] doc: bindings: mfd: act8945a: Update the example
In-Reply-To: <20160901112251.GK4921@dell>
References: <1472722201-31872-1-git-send-email-wenyou.yang@atmel.com>
 <1472722201-31872-4-git-send-email-wenyou.yang@atmel.com>
 <20160901112251.GK4921@dell>
Message-ID: <20160901124746.vbhrz4f53vb63d7t@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, Sep 01, 2016 at 12:22:51PM +0100, Lee Jones wrote:
> On Thu, 01 Sep 2016, Wenyou Yang wrote:
> 
> > Since the act8945a-charger is regarded as a sub-device and it using
> > "interrupts" property, update the examples section.
> > 
> > Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> > ---
> > 
> > Changes in v9: None
> > Changes in v8: None
> > Changes in v7: None
> > Changes in v6: None
> > Changes in v4: None
> > 
> >  Documentation/devicetree/bindings/mfd/act8945a.txt | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> 
> This is a functional change.  I'll require a DT Ack.

Wenyou Yang forgot to take over Rob's Acked-By from the previous
version: https://patchwork.kernel.org/patch/9298871/

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/51e83537/attachment.sig>
