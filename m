From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sat, 10 Nov 2018 18:12:32 +0100 (CET)
Subject: [PATCH] Staging: vchi: Add license id and change int type
In-Reply-To: <d6e6a908-8ef6-e2a5-0a78-7bc21be957e4@i2se.com>
References: <20181107000738.26963-1-andrealmeid@riseup.net>
 <d6e6a908-8ef6-e2a5-0a78-7bc21be957e4@i2se.com>
Message-ID: <779995221.314921.1541869952181@email.ionos.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andre,

> Stefan Wahren <stefan.wahren@i2se.com> hat am 7. November 2018 um 09:30 geschrieben:
> 
> 
> >
> > Signed-off-by: Andr? Almeida <andrealmeid@riseup.net>
> >
> > ---
> >
> > Hello! This is my first patch to Linux Kernel. Let me know any feedback
> > ---
> >  drivers/staging/vc04_services/interface/vchi/vchi_mh.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> > index 198bd076b666..42fc0c693d43 100644
> > --- a/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> > +++ b/drivers/staging/vc04_services/interface/vchi/vchi_mh.h
> > @@ -1,5 +1,5 @@
> > -/**
> > - * Copyright (c) 2010-2012 Broadcom. All rights reserved.
> > +/* SPDX-License-Identifier: GPL-2.0 */
> 
> Please use the C++ style for the SPDX id.

Apologies. Please ignore this suggestion. C style is correct for header files.

Stefan
