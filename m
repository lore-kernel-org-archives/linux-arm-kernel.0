From: phdm@macq.eu (Philippe De Muyter)
Date: Wed, 5 Mar 2014 23:37:53 +0100
Subject: mx6q csi driver ?
Message-ID: <20140305223753.GA28522@frolo.macqel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I try to write a linux driver for a cmos sensor connected to a sabresd
board, but I wonder where to continue.

I first considered using the freescale 3.10.17 beta kernel,
which has already a csi v4l2 driver (but using deprecated v4l2 internals).
That does not work at the moment because I need spi to configure my
sensor and spi does not work with that kernel on my sabresd board :(
I should also mention that reboot does not work either.

As I also had worked with linus's tree and currently have 3.14-rc4
working on my sabresd board, with functional spi and reboot, I tried
to port the freescale 3.10.17 v4l2 csi driver modules to 3.14-rc4,
but now my kernel is locked at startup (it does not even issue
one message after 'Uncompressing kernel...').

What would be the best way to write my CMOS sensor driver ?  (I aim to
push it to linus when finished), and are there more specific mailing lists
for either the freescale kernel or the mx6 csi driver ?

TIA

-- 
Philippe De Muyter +32 2 6101532 Macq SA rue de l'Aeronef 2 B-1140 Bruxelles
