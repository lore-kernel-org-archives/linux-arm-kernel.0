From: horms@verge.net.au (Simon Horman)
Date: Fri, 7 Jun 2013 17:06:37 +0900
Subject: [PATCH v8 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <201306020128.05914.sergei.shtylyov@cogentembedded.com>
References: <201306020128.05914.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130607080637.GC22598@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 02, 2013 at 01:28:05AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130528' tag.  It was created to fix the shortcomings in the
> R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
> spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
> to touch both subtrees). The patches were conceived with the complete
> bisectability goal in mind.
> 
> [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
> [2/9] ehci-platform: add pre_setup() method to platform data
> [3/9] ARM: shmobile: r8a7779: setup EHCI internal buffer
> [4/9] phy-rcar-usb: remove EHCI internal buffer setup
> [5/9] ARM: shmobile: r8a7779: remove USB PHY 2nd memory resource
> [6/9] phy-rcar-usb: correct base address
> [7/9] phy-rcar-usb: add platform data
> [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
> [9/9] phy-rcar-usb: handle platform data
> 
>    The patchset is completely ready to be merged now.

Can I confirm that the plan is for me to merge this code?

If so, I should be able to do so next week.
