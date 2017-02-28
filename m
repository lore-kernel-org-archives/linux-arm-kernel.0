From: robh@kernel.org (Rob Herring)
Date: Mon, 27 Feb 2017 18:11:14 -0600
Subject: [PATCH v2 01/17] dt-bindings: Add vendor prefix for Actions Semi
In-Reply-To: <06838745-f8f2-756f-9719-2e7da8964203@suse.de>
References: <20170224034055.18807-1-afaerber@suse.de>
 <20170224034055.18807-2-afaerber@suse.de>
 <06838745-f8f2-756f-9719-2e7da8964203@suse.de>
Message-ID: <20170228001114.s4nrgjhfaxxvw76q@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 27, 2017 at 03:57:19PM +0100, Andreas F?rber wrote:
> Am 24.02.2017 um 04:40 schrieb Andreas F?rber:
> > Actions Semiconductor was listed on NASDAQ as ACTS until Dec 16, 2016.
> > 
> > Cc: mp-cs at actions-semi.com
> > Signed-off-by: Andreas F?rber <afaerber@suse.de>
> > ---
> >  v1 -> v2:
> >  * Reverted from "acts" to "actions" (cf. IAP140 "mrvl" vs. "marvell")
> >  
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index a76b981..64f8469 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -6,6 +6,7 @@ using them to avoid name-space collisions.
> >  abcn	Abracon Corporation
> >  abilis	Abilis Systems
> >  active-semi	Active-Semi International Inc
> > +actions	Actions Semiconductor Co., Ltd.
> 
> If the use of "actions" gets ack'ed, I realize it should move one line up.

With that fix,

Acked-by: Rob Herring <robh@kernel.org>
