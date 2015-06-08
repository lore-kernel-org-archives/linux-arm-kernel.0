From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 8 Jun 2015 14:42:45 -0700
Subject: [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20150608214245.GA29640@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> This patch series adds Clock Domain support to the Clock Pulse Generator
> (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
> be used on shmobile SoCs without device power domains (R-Car Gen1 and
> Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
> that are part of the CPG Clock Domain using Runtime PM, or for system
> suspend/resume, similar to SoCs with device power domains (SH-Mobile and
> R-Mobile).

The clk part looks fine (although it's not really clk framework
related). Did you want the clk patches to go through the clk tree
though? It wasn't clear from this cover letter.

If not, you can have my ack on these patches:

>     clk: shmobile: Add CPG Clock Domain support
>   * clk: shmobile: r8a7778: Add CPG Clock Domain support
>   * clk: shmobile: r8a7779: Add CPG Clock Domain support
>     clk: shmobile: rcar-gen2: Add CPG Clock Domain support
>   * clk: shmobile: rz: Add CPG Clock Domain support

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
