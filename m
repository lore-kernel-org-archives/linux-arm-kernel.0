From: robherring2@gmail.com (Rob Herring)
Date: Sat, 02 Jun 2012 15:48:11 -0500
Subject: ARM PCI controller registration and representation using device
 tree?
In-Reply-To: <4113992.BTnO0ZYQON@bender>
References: <4113992.BTnO0ZYQON@bender>
Message-ID: <4FCA7C0B.5070304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/2012 09:18 AM, Florian Fainelli wrote:
> Hi,
> 
> I was wondering if anyone had started working on representing the various PCI 
> controllers found on SoCs to a device tree representation?

Reusing the existing PCI bindings is the right way to go.

> It seems like quite some generic code could be borrowed from PowerPC, 
> especially the parsing of the PCI ranges, though I don't see ARM directly 
> exposing a struct pci_controller to easily allow that.

The PowerPC PCI DT code needing to be re-factored to generic code was my
conclusion as well in my brief look at it.

Rob

> 
> Any thoughts about this?
> 
> Thanks.
