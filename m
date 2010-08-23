From: jason.mcmullan@netronome.com (Jason McMullan)
Date: Mon, 23 Aug 2010 11:20:43 -0400
Subject: Policy question: criteria for submission to mainline for a new SoC?
Message-ID: <AANLkTimpz2YVTqd1EVqoX3yKKQ-peAy=OgwEDmz-iVi-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there! So, I have the responsibility of handling our Linux Kernel
GPL requirements at Netronome for our NFP3200 series of processors
(ARM MPCore based SoCs with 40 IXP style microengines), and I have
some policy questions.

We (currently) have two products that the NFP3200 is mounted on,
both of which are evaluation devices for our customers. We provide
our customers *complete* source code for *all* GPL components
(Linux, Busybox, root fs, etc. etc. etc).

We also provide our customers non-GPL components (custom bootloader,
board initialization routines, etc), if they wish to go the uCOS
or VxWorks path.

So our customers (and anyone who asks us for a copy of the GPL
component sources) are covered, and, as far as I can tell, we are
GPL compliant. (If not, let me know, and we'll fix it!)

However, I am not sure if it is worth cluttering up the Linux ARM
arch mainline with yet another rare SoC. If the Linux ARM community
would like the sources, I am more than willing to post them on
the list, but there's not much new or interesting to see - just
a lot of trivial SoC hardware details.

So, the questions are:

A) Is anyone interested in the NFP3200 SoC patches?

B) What is the general policy for '# of units sold' for whether
   a SoC should be added to the Linux ARM mainline?

-- 
Jason S. McMullan
Netronome Systems, Inc.
http://www.netronome.com
