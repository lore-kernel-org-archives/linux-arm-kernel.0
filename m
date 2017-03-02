From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Mar 2017 15:46:56 +0100
Subject: [PATCH 0/3] arm64: dts: r8a7796: Add Secondary CPU Cores
In-Reply-To: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
References: <1487345435-1088-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170302144655.GT6301@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2017 at 04:30:32PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the second Cortex-A57 CPU core, and the
> Cortex-A53 L2 cache-controller and CPU nodes on the Renesas R-Car M3-W
> SoC to its DTS file.
> 
> Note that these patches add hardware description; actual enabling of the
> CPU depends on the PSCI firmware.
> 
> With the current firmware version (v2.16.0), only the CA57 CPU cores are
> enabled, hence the last patch does not introduce undeterministic
> scheduling behavior due to migration between big and LITTLE cores.
> 
> Tested on r8a7796/salvator-x, with CPU hot(un)plug and system suspend.
> 
> Thanks for applying!
> 
> Geert Uytterhoeven (2):
>   arm64: dts: r8a7796: Add CA53 L2 cache-controller node
>   arm64: dts: r8a7796: Add Cortex-A53 CPU cores
> 
> Takeshi Kihara (1):
>   arm64: dts: r8a7796: Add Cortex-A57 CPU cores

Hi Geert,

thanks for your work in this area.

There seems to be some more work required to get patch 2/3 across the line
so I am holding off on applying this series for now.
