From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 02 Jun 2016 15:53:33 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <20160602144542.6bc1b421@free-electrons.com>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <8313817.cgODJZVrao@wuerfel> <20160602144542.6bc1b421@free-electrons.com>
Message-ID: <7070543.PV5raqmBSF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, June 2, 2016 2:45:42 PM CEST Thomas Petazzoni wrote:
> 
> On Thu, 02 Jun 2016 14:34:14 +0200, Arnd Bergmann wrote:
> 
> > I think some other PCI hosts just move the interrupt-controller
> > and #interrupt-cells properties into the PCI host node itself,
> > which avoids the ambiguity here.
> 
> Do you have an example of this? I have modeled my DT binding after the
> one used by the pci-dra7xx driver, which is in the same situation as I
> am in terms of interrupt handling.
> 
> But I can indeed try to make the top-level PCIe controller node the
> interrupt controller. Let me try that quickly.
> 

Looking at the binding files, I see only this one:

Documentation/devicetree/bindings/pci/altera-pcie.txt

and a couple of others using a child node.

	Arnd
