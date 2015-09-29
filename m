From: horms@verge.net.au (Simon Horman)
Date: Tue, 29 Sep 2015 09:37:51 +0900
Subject: [PATCH] ARM: shmobile: r8a7794: link PCI USB devices to USB PHY
In-Reply-To: <10927620.1TFu7PRvi4@wasted.cogentembedded.com>
References: <10927620.1TFu7PRvi4@wasted.cogentembedded.com>
Message-ID: <20150929003751.GB20067@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sun, Sep 13, 2015 at 02:00:19AM +0300, Sergei Shtylyov wrote:
> Describe the PCI USB devices that are behind the PCI bridges, adding necessary
> links to the USB PHY device.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against 'renesas-devel-20150911v2-v4.2' tag of Simon Horman's
> 'renesas.git' repo plus the R8A7794/SILK PCI USB and USB PHY support patches
> just posted.

Does this series have any dependencies (e.g. bindings) other
than the aforementioned R8A7794/SILK PCI USB and USB PHY support patches?
