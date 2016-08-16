From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Tue, 16 Aug 2016 20:28:56 +0200
Subject: [PATCH v2 1/2] devicetree: Add vendor prefix for Shenzhen
 Sunchip Technology Co., Ltd
In-Reply-To: <20160816125624.GA20716@rob-hp-laptop>
References: <20160812235312.GB10557@vip.cybercity.dk>
 <bae6ad6c04f7567b224e008ab27b32d2dac1d9c1.1471125083.git.ccc94453@vip.cybercity.dk>
 <20160816125624.GA20716@rob-hp-laptop>
Message-ID: <20160816182855.2hdupen4dcmczxiw@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 16, 2016 at 07:56:24AM -0500, Rob Herring wrote:
> On Thu, Aug 11, 2016 at 10:11:51PM +0200, Rask Ingemann Lambertsen wrote:
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > index 1992aa9..fbad2cea 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> > @@ -256,6 +256,7 @@ ste	ST-Ericsson
> >  stericsson	ST-Ericsson
> >  syna	Synaptics Inc.
> >  synology	Synology, Inc.
> > +sunchip	Shenzhen Sunchip Technology Co., Ltd
> >  SUNW	Sun Microsystems, Inc
> 
> These are not in alphabetical order. Maybe someone thought uppercase 
> should be separate, but I don't. So please fix the ordering here moving 
> SUNW before syna.

I'm new to this, so I could use a bit of guidance here. Is it OK if I
send a follow-up patch to fix the ordering or should I send a patch to
fix the ordering first, before the sunchip prefix is added?

I never considered the possibility that the list wouldn't be in
alphabetical order to begin with, so the brain power went into deciding
if uppercase should be sorted separately.

-- 
Rask Ingemann Lambertsen
Danish law requires addresses in e-mail to be logged and stored for a year
