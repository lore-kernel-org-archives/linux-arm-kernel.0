From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 19 Jan 2010 18:09:39 +0000
Subject: [RFC 18/18] arm: mm: qsd8x50: Fix incorrect permission faults
In-Reply-To: <20100119174313.GE1323@shareable.org>
References: <20100119171033.GA1323@shareable.org>
	<1263922428.1951.63.camel@m0nster>
	<20100119174313.GE1323@shareable.org>
Message-ID: <20100119180939.GD1886@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 19, 2010 at 05:43:13PM +0000, Jamie Lokier wrote:
> Daniel Walker wrote:
> > Everything I release will ultimately be licensed under the GPLv2
> > regardless of the license in the current files.. So it's just a matter
> > of removing that old license ..
> 
> Ok.  Please do :-)
> 
> > > For another file, I'm not sure that adding "All rights reserved" is ok.
> > > Under the GPL, all rights are _not_ reserved:
> > 
> > This would be a problem because our lawyers mandate this.. AFAIK, it
> > doesn't change the licensing tho.
> 
> If it doesn't change the license, why is it mandated?
> 
> Sounds like your lawyers aren't very familiar with open source licensing.

It is quite normal to do:

 (C) 2010 Joe Bloggs, All Rights Reserved.

 GPLv2 boiler plate.

Here's some examples:

 * Copyright (C) 2007 Red Hat, Inc.  All rights reserved.  This copyrighted
 * material is made available to anyone wishing to use, modify, copy, or
 * redistribute it subject to the terms and conditions of the GNU General
 * Public License v.2.

 *   Copyright 2000-2008 H. Peter Anvin - All Rights Reserved

 * Copyright (C) 2008 Silicon Graphics, Inc. All rights reserved.

 *      Copyright (C) IBM Corporation, 2004. All rights reserved

 *   Copyright 2007 rPath, Inc. - All Rights Reserved
