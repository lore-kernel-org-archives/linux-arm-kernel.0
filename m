From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 11 Jul 2017 19:56:59 +0200
Subject: i.MX 6 and PCIe DMA issues
In-Reply-To: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
References: <04e1d18a504a477b84f5a9ec661dc9ae@MEN-EX01.intra.men.de>
Message-ID: <20170711175659.GC28931@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 11, 2017 at 01:40:57PM +0000, Moese, Michael wrote:
> Hello ARM folks,
> I turn to you in hope you have any hints or directions on the problem I describe below.
> 
> I am currently investigating strange behavior of our i.MX 6 (Quad) board with an FPGA connected to to PCI Express. This FPGA contains, among others, an Ethernet (10/100 Mbps) IP core. 

FYI: I'm using am IMX6 quad with an intel i210 PCIe Ethernet
controller. It works fine. So you might want to look at how the igb
driver does its buffer handling.

       Andrew
