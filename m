From: horms@verge.net.au (Simon Horman)
Date: Thu, 2 Mar 2017 16:05:45 +0100
Subject: [PATCH v4 0/2] arm64: dts: r8a7795: Add Cortex-A53 CPU cores and
 PMU
In-Reply-To: <1487944768-31983-1-git-send-email-geert+renesas@glider.be>
References: <1487944768-31983-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170302150545.GV6301@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Fri, Feb 24, 2017 at 02:59:26PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the Cortex-A53 CPU cores and PMU on the Renesas
> R-Car H3 SoC to its DTS file.
> 
> Note that these patches describes the hardware; actual enabling of the
> CPU depends on the PSCI firmware.
> 
> With the current firmware version (v2.16.0), only the CA57 CPU cores are
> enabled, hence these patches do not introduce undeterministic scheduling
> behavior due to migration between big and LITTLE cores.
> 
> Changes compared to v3:
>   - Drop bogus links from the pmu_a57 node to the CA53 nodes,
>   - Add Cortex-A53 PMU node.
> 
> Tested on r8a7795/salvator-x, with CPU hot(un)plug and system suspend.
> 
> Thanks for applying!

I believe this patch-set is in keeping with the face-to-face discussion
between Magnus, yourself, myself and others in Brussels last month.

With that in mind I have queued this up for v4.12.
