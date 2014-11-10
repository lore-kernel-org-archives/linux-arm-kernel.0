From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 10 Nov 2014 09:11:30 +0100
Subject: [PATCH v8 4/8] ARM: dts: Enable Broadcom Cygnus SoC
In-Reply-To: <54604A71.1010000@broadcom.com>
References: <sbranden@broadcom.com> <5982323.RDuqIHPULA@wuerfel>
 <54604A71.1010000@broadcom.com>
Message-ID: <2221359.WPjXKG5OT3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 November 2014 21:17:37 Scott Branden wrote:
> On 14-11-09 12:38 PM, Arnd Bergmann wrote:
> > On Sunday 09 November 2014 09:23:11 Greg Kroah-Hartman wrote:
> >> On Sat, Nov 08, 2014 at 10:49:09PM -0800, Olof Johansson wrote:
> >>>>>> +/*
> >>>>>> + * Copyright 2014 Broadcom Corporation.  All rights reserved.
> >>>>>> + *
> >>>>>> + * Unless you and Broadcom execute a separate written software license
> >>>>>> + * agreement governing use of this software, this software is licensed
> >>>>>> to you
> >>>>>> + * under the terms of the GNU General Public License as
> >>>>>> + * published by the Free Software Foundation version 2.
> >>>>>> + *
> >>>>>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> >>>>>> + * kind, whether express or implied; without even the implied warranty
> >>>>>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >>>>>> + * GNU General Public License for more details.
> >>>>>
> >>>>>
> >>>>> We ask for new DT contents to be added with dual BSD/GPL license, to
> >>>>> allow for reuse of the DT data structures in other projects as well.
> >>>>> There's currently a lot of activity going on relicensing the current
> >>>>> files so I recommend sorting it out before they are added if you can.
> >>>>
> >>>>
> >>>> This may take more time than you think.  I am going to have to go through
> >>>> legal to get such a license created. Also, why would you need dual license?
> >>>> If it is BSD that should serve both purposes?
> >>>
> >>> I haven't followed the discussion close enough to know if there's been
> >>> discussion about single-license BSD vs dual BSD/GPL.
> >
> > I think for all practical purposes, BSD and dual BSD/GPL is the same and
> > listing it as dual was meant as a clarification to make it easier to see
> > that all files in the kernel are GPLv2 compatible.
> A dual BSD/GPL may involve having me get a lawyer to create such a 
> header.  I would prefer to leave it as GPL for now until some concrete 
> decision has finally been made on this by the rest of the community? 
> Or, I can put it as BSD right now if that helps?

I would prefer a pure BSD header for the moment over a pure GPL header.
The last thing we want is to force other operating systems to create
another set of dts files for the same hardware.

	Arnd
