From: horms@verge.net.au (Simon Horman)
Date: Fri, 10 Mar 2017 10:28:50 +0100
Subject: [PATCH v2 0/5] arm64: dts: r8a7796: Add Secondary CPU Cores
In-Reply-To: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
References: <1488909806-3322-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170310092850.GG21820@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 07:03:21PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series adds the second Cortex-A57 CPU core, the Cortex-A57
> PMU, and the Cortex-A53 L2 cache-controller, CPU, and PMU nodes on the
> Renesas R-Car M3-W SoC to its DTS file.
> 
> Note that these patches add hardware description; actual enabling of the
> CPU depends on the PSCI firmware.
> 
> With the current firmware version (v2.16.0), only the CA57 CPU cores are
> enabled, hence the last patch does not introduce undeterministic
> scheduling behavior due to migration between big and LITTLE cores.
> 
> Changes compared to v1:
>   - Add Cortex-A57 and Cortex-A53 PMU nodes,
>   - Drop unit address and reg property for integrated cache-controller.
> 
> Tested on r8a7796/salvator-x, with CPU hot(un)plug and system suspend.
> 
> Thanks for applying!

Thanks.

This is appears to be in keeping with the discussion between Magnus,
yourself, myself and others in Brussels last month. Accordingly I have
queued-up these changes.
