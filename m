From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 14 Nov 2013 17:23:08 +0100
Subject: [PATCHv4] dmaengine: Add support for BCM2835
In-Reply-To: <CABDT8WyUK6tDneDEm0G3o0zJHXaVTZp8JAMxOp5LRKQYG-7Umw@mail.gmail.com>
References: <5283BC93.1090801@koalo.de> <2385512.qcT1vt8HYp@flatron>
 <CABDT8WyUK6tDneDEm0G3o0zJHXaVTZp8JAMxOp5LRKQYG-7Umw@mail.gmail.com>
Message-ID: <11018682.0TjgocUWod@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 of November 2013 17:14:31 Florian Meier wrote:
> >> >> I am becoming desperate anyway that this migration will ever fully
> >> >> take place....
> >> >
> >> > Why not? It's just a matter of people like you working on this (and
> >> > addressing some review comments ;)).
> >>
> >> The most common comment about this is that people will not put effort in
> >> the upstream kernel as long as there is no comfortable way for debugging
> >> in the upstream kernel (i.e. at least USB support).......
> >
> > Right, you need USB to have ethernet working. Still, IMHO UART (for
> > console) + ethernet (for file transfer or NFS root) is the reasonable
> > setup allowing you to debug further drivers in a comfortable way.
> 
> I am fine with UART and switching SD cards :-)
> But apparently this is not generally accepted.

Still, isn't some work on USB support for RPi already going on? I believe
Matt Porter (now on Cc) has been working on unifying dwc2 host-mode
driver with Samsung s3c-hsotg device-mode driver (for the same IP) to
get full OTG support on all applicable platforms.

Best regards,
Tomasz
