From: paul@pwsan.com (Paul Walmsley)
Date: Sat, 4 Feb 2012 10:32:16 -0700 (MST)
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <20120204165736.GI1275@n2100.arm.linux.org.uk>
References: <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
 <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
 <CANOLnOPm-ZKRvu1PVs-jU2sceehRiwNPd=ysu2SDsLbarAPVbw@mail.gmail.com>
 <alpine.DEB.2.00.1202040928320.9453@utopia.booyaka.com>
 <20120204165736.GI1275@n2100.arm.linux.org.uk>
Message-ID: <alpine.DEB.2.00.1202041029520.9453@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 4 Feb 2012, Russell King - ARM Linux wrote:

> [detailed discussion of framing errors]

Thanks for the detailed description.  If the driver is in fact discarding 
characters with framing errors -- which I have not personally verified -- 
then taking further action there is pointless.


- Paul
