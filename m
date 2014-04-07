From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Mon, 7 Apr 2014 15:38:50 +0100
Subject: [PATCH v7 5/6] pci: Export find_pci_host_bridge() function.
In-Reply-To: <20140407142045.GO17163@e106497-lin.cambridge.arm.com>
References: <1394811272-1547-1-git-send-email-Liviu.Dudau@arm.com>
 <1394811272-1547-6-git-send-email-Liviu.Dudau@arm.com>
 <20140404233948.GC15806@google.com>
 <20140407142045.GO17163@e106497-lin.cambridge.arm.com>
Message-ID: <20140407153850.3c9ef3e5@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > If we *do* export it, I'd like it to have a more conventional name, e.g.,
> > something starting with "pci_".
> 
> Understood. pci_find_host_bridge() ?

pci_get_host_bridge() and take a reference IMHO ? If your primary bus is
not PCI then your PCI "host" bridge could be hot swappable so the API at
least ought to get that right.

Alan
