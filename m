From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 27 Jan 2016 14:27:16 +0000
Subject: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
In-Reply-To: <5660994.Bgxrr57r2H@wuerfel>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
 <5660994.Bgxrr57r2H@wuerfel>
Message-ID: <8520D5D51A55D047800579B09414719825873D88@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
> 
> On Tuesday 12 January 2016 23:06:10 Bharat Kumar Gogada wrote:
> > Removing struct hw_irq and adding generic PCI core API's.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Removing architecure dependecy structure struct hw_irq which is ARM
> > 32-bit specific structure, and adding generic PCI core API's to
> > register to PCI subsytem.
> > Removing funtions which are not being used with generic API's.
> >
> 
> typo: s/hw_irq/hw_pci/
> 
Yes, its struct hw_pci, will correct it in next patch.
