From: mroberto@cetuc.puc-rio.br (Marcelo Jimenez)
Date: Mon, 31 May 2010 20:20:18 -0300
Subject: BSE nanoengine git tree
Message-ID: <AANLkTiny5Y6zgrpSJZypB3OoXgj1OQsXkBELB7AMrhdF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have been sending some patches to re-add BSA nanoengine support back
into the kernel tree since 2.6.32 IIRC. Since none of them has made
upstream, I have created a repository on github with the hope that
people interested in the support for this board can test and/or give
some feedback.

For those interested, the code has some fixed RTC logic, has support
for PCMCIA and I am working on PCI ethernet support. Currently I am
having problems trying to enable the network chip due to the lack of
documentation, so any ideas are welcome.

The URL is:

http://github.com/mrjimenez/linux-2.6

There are two branches: nanoengine and nano-pci. The branch nanoengine
is suppose to be the stable one, nano-pci is where I am doing the pci
ethernet driver work.

Any feedback is welcome.

Regards,
Marcelo.
