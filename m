From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Jan 2016 23:23:32 +0100
Subject: [PATCH V2 2/5] PCI: xilinx: Removing struct hw_irq structure.
In-Reply-To: <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
References: <1452620173-4905-1-git-send-email-bharatku@xilinx.com>
 <1452620173-4905-3-git-send-email-bharatku@xilinx.com>
Message-ID: <5660994.Bgxrr57r2H@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 23:06:10 Bharat Kumar Gogada wrote:
> Removing struct hw_irq and adding generic PCI core API's.
> 
> Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> ---
> Removing architecure dependecy structure struct hw_irq which is ARM 32-bit
> specific structure, and adding generic PCI core API's to register to
> PCI subsytem.
> Removing funtions which are not being used with generic API's.
> 

typo: s/hw_irq/hw_pci/

	Arnd
