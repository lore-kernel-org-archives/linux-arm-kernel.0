From: w@1wt.eu (Willy Tarreau)
Date: Fri, 3 May 2013 21:23:51 +0200
Subject: MVEBU PCI Express support
In-Reply-To: <5183F858.1050804@itooo.com>
References: <5183F858.1050804@itooo.com>
Message-ID: <20130503192351.GN10563@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

On Fri, May 03, 2013 at 07:48:08PM +0200, Greg wrote:
> Hello guys,
> 
> this one is targeted to the Free Electrons guys : should I start 
> investigating by myself or are you planning to release a patch for 
> supporting PCI express on Marvell Armada* platforms ?

Look at their github, there is a patchset for the PCI-express. I
managed to get some NICs and the USB3 controller to work in the 
armada370 using it, I have not tried the armadaXP yet.

Willy
