From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Thu, 04 Apr 2013 19:01:27 -0700 (PDT)
Subject: [PATCH 0/8] Reorganize R8A7779/Marzen USB code
In-Reply-To: <201304050251.44464.sergei.shtylyov@cogentembedded.com>
References: <201304050251.44464.sergei.shtylyov@cogentembedded.com>
Message-ID: <87vc81ka6k.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

>    Here's the set of 4 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130404v2' tag and the 2 Ether patches I've reposted yesterday.
> It was created to fix the shortcomings in the R8A7779/Marzen USB platform code
> and R8A7779 USB common PHY driver, and so spans both arch/arm/mach-shmobile/
> and drivers/usb/ subtrees (some patches have to touch both subtrees).
> The patches were conceived with the complete bisectability goal in mind.
> 
> [1/8] ARM: shmobile:Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
> [2/8] ehci-platform: add init() method to platform data
> [3/8] ARM: shmobile: R8A7779: setup EHCI internal buffer
> [4/8] rcar-phy: remove EHCI internal buffer setup
> [5/8] rcar-phy: correct base address
> [6/8] rcar-phy: add platform data
> [7/8] ARM: shmobile: Marzen: pass platform data to USB PHY device
> [8/8] rcar-phy: handle platform data
> 
>    I'm not sure thru which tree this patchset should be merged, however it turns
> out that it's too late now to push it thru Felipe Balbi's USB tree for 3.10, so
> maybe the patchset can be merged thru Simon's tree with Felipe's and Alan
> Stern's ACKs.

I guess you already got request about patch style from Simon.
When you send v2 patch, could you please add "this patch is tested on xxxx bard"
on each patch's comment area ?

Then,
for all patches

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
