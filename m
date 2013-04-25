From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 25 Apr 2013 10:09:32 +0100
Subject: [RFC PATCH v3 02/17] Documentation: devicetree: arm: cpus/cpu
 nodes bindings updates
In-Reply-To: <20130424195820.GM4998@game.jcrosoft.org>
References: <1366824502-19729-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366824502-19729-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20130424195820.GM4998@game.jcrosoft.org>
Message-ID: <20130425090931.GB25870@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 24, 2013 at 08:58:20PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:

[...]

> > +     - compatible:
> > +             Usage: required
> > +             Value type: <string>
> > +             Definition: should be one of:
> > +                         "arm,arm710t"
> > +                         "arm,arm720t"
> > +                         "arm,arm740t"
> > +                         "arm,arm7ej-s"
> > +                         "arm,arm7tdmi"
> > +                         "arm,arm7tdmi-s"
> > +                         "arm,arm9es"
> > +                         "arm,arm9ej-s"
> > +                         "arm,arm920t"
> > +                         "arm,arm922t"
> > +                         "arm,arm925"
> > +                         "arm,arm926e-s"
> > +                         "arm,arm926ej-s"
> > +                         "arm,arm940t"
> > +                         "arm,arm946e-s"
> > +                         "arm,arm966e-s"
> > +                         "arm,arm968e-s"
> > +                         "arm,arm9tdmi"
> > +                         "arm,arm1020e"
> > +                         "arm,arm1020t"
> > +                         "arm,arm1022e"
> > +                         "arm,arm1026ej-s"
> the common name is arm926ejs / arm1026ejs & co

The TRMs names are arm926ej-s/arm1026ej-s/... and other machs are using that
nomenclature already in dts files, time to consolidate.

Lorenzo
