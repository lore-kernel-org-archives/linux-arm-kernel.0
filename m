From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 01:06:39 +0100
Subject: [RFC 2/4] PCI: generic: Add support for ARM64 and MSI(x)
In-Reply-To: <20141105234058.GK6168@google.com>
References: <1411937610-22125-1-git-send-email-suravee.suthikulpanit@amd.com>
 <2355100.WsW1DXh57P@wuerfel> <20141105234058.GK6168@google.com>
Message-ID: <2679650.sLyVOFDaTG@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 05 November 2014 16:40:58 Bjorn Helgaas wrote:
> > 
> > See below for a sample patch I just did. It duplicates the code from
> > pci_common_init_dev/pci_common_init because we know that all users
> > of pci_common_init_dev are modern and only pass a single host bridge.
> > The new pci_common_init_dev is simpler than the old one but should
> > do the exact same thing for all current users, with the addition
> > of propagating the return value.
> 
> Same with this one; I'm ignoring for now on the theory that this was just a
> sample to show the idea, and a more formal patch might come later.
> 

Correct. Or we might not do it at all, if some of the other patches
are done before we need this.

	Arnd
