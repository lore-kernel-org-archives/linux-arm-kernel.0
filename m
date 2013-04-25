From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 25 Apr 2013 04:04:58 +0200
Subject: dma cache coherency on Armada XP dev board
In-Reply-To: <20130424182202.GK13884@titan.lakedaemon.net>
References: <CANX6Damwoz0MSEu5Sb4uKTUhcsC0g+ua1DjuQuMEzXyBOkL7PA@mail.gmail.com>
 <20130424182202.GK13884@titan.lakedaemon.net>
Message-ID: <20130425040458.1084355f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Viral, Jason,

On Wed, 24 Apr 2013 14:22:02 -0400, Jason Cooper wrote:

> > Recently, I faced DMA related issue. While moving data from memory
> > to the device, I  found that sometimes I am getting Junk data. I
> > looked further to see if this is related to DMA Sync problem. So,
> > basically, I have following questions,
> > 
> > 1. As per [1] ARMADA has Coherency Fabric that sits between CPU and
> > other devices and takes care of hardware based I/O cache coherency.
> > Do we need to enable any support for the same in software ? I am
> > running 3.0.29 based linux kernel. How do I verify that I have all
> > the things enabled in Linux Kernel.
> 
> 3.0.29 must be a Marvell supplied kernel.  You'd have to ask them,
> unfortunately.  I've added the free-electrons guys as they are
> assisting Marvell with adding ArmadaXP/370 to the mainline kernel.
> 
> My advice is to try building the mainline kernel from kernel.org and
> see if the problem remains.
> 
> Thomas and the guys may be able to help you with specific questions
> regarding the Marvell kernel.

As Jason state, 3.0.29 is a kernel that has been heavily patched by
Marvell, so you should consult your Marvell support to get help with
this kernel. We do only support the mainline kernel for the Armada 370
and Armada XP platforms. Do not hesitate to get back to us if you face
similar issues with the mainline kernel.

Best regards,

Thomas Petazzoni
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
