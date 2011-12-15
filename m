From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 15 Dec 2011 15:28:14 +0100
Subject: iMX25 framebuffer 4bpp support?
Message-ID: <4EEA03FE.5030400@kernelconcepts.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello!
For a project a 4bpp framebuffer connected to a monochrome grayscale
display could be interesting.
What I found out by now is that the Linux kernel framebuffer
infrastructure can support 4bpp grayscale.
Looking at the iMX framebuffer driver though made me unsure if this
would support that mode. I know that the iMX25 can support this (at
least according to Freescale information).

So, can someone confirm that the iMX(25) framebuffer driver can driver a
4bpp grayscale display?

Many thanks!

Cheers
  nils

-- 
kernel concepts GmbH       Tel: +49-271-771091-12
Sieghuetter Hauptweg 48
D-57072 Siegen             Mob: +49-176-21024535
http://www.kernelconcepts.de
