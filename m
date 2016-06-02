From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 2 Jun 2016 14:45:42 +0200
Subject: [PATCH 1/3] dt-bindings: add DT binding for the Aardvark PCIe
 controller
In-Reply-To: <8313817.cgODJZVrao@wuerfel>
References: <1464858585-10963-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1464858585-10963-2-git-send-email-thomas.petazzoni@free-electrons.com>
 <20160602122405.GG17343@lunn.ch> <8313817.cgODJZVrao@wuerfel>
Message-ID: <20160602144542.6bc1b421@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 02 Jun 2016 14:34:14 +0200, Arnd Bergmann wrote:

> I think some other PCI hosts just move the interrupt-controller
> and #interrupt-cells properties into the PCI host node itself,
> which avoids the ambiguity here.

Do you have an example of this? I have modeled my DT binding after the
one used by the pci-dra7xx driver, which is in the same situation as I
am in terms of interrupt handling.

But I can indeed try to make the top-level PCIe controller node the
interrupt controller. Let me try that quickly.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
