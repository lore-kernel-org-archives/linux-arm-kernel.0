From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Fri, 16 Oct 2009 18:35:37 +0200
Subject: kirkwood pci support
Message-ID: <874opzthye.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've been playing with an OpenRD-client machine and tried to get working
a more recent kernel than the default 2.6.22. Unfortunately, looks like
there's some issues with the PCI support. The machine has a XGI Z11
card and the xgi framebuffer driver has not been able to initialise
the card.
After some debugging I've made the patch I'm joining to this mail.
