From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 13 Jan 2016 15:51:21 -0800
Subject: [PATCH 1/2] of: add vendor prefix for UniWest
In-Reply-To: <CAL_JsqKLDZ55XtA2fsy_0s50wA-o_cvwgFNb5Y+Qq14ErJJbJA@mail.gmail.com>
References: <b11bf2208fe30b96c4d82e634e8abe04343754de.1452717014.git.stillcompiling@gmail.com>
 <CAL_JsqKLDZ55XtA2fsy_0s50wA-o_cvwgFNb5Y+Qq14ErJJbJA@mail.gmail.com>
Message-ID: <20160113155121.48a5f0b1@jclayton-pc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jan 2016 17:37:46 -0600
Rob Herring <robh+dt@kernel.org> wrote:

> On Wed, Jan 13, 2016 at 2:45 PM, Joshua Clayton
> <stillcompiling@gmail.com> wrote:
> > United Western Technologies Corp, known primarily as UniWest,
> > is a manufacturer of eddy current and ultrasonic testing equipment.
> >
> > Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > 55df1d4..7dabdee 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -230,6
> > +230,7 @@ toradex     Toradex AG toshiba        Toshiba Corporation
> >  toumaz Toumaz
> >  tplink TP-LINK Technologies Co., Ltd.
> > +uniwest        United Western Technologies Corp (UniWest)
> >  tronfy Tronfy
> 
> Alphabetical order please.
Gah. It was alphabetical until I rebased against v4.4

Will fix.
> 
> >  truly  Truly Semiconductors Limited
> >  upisemi        uPI Semiconductor Corp.
> > --
> > 2.5.0
> >
