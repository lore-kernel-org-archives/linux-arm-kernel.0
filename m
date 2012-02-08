From: robherring2@gmail.com (Rob Herring)
Date: Tue, 07 Feb 2012 18:43:02 -0600
Subject: [PATCH v6 00/15] Per SoC descriptor
In-Reply-To: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
References: <1328661059-24584-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <4F31C516.1040008@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2012 06:30 PM, Marc Zyngier wrote:
> This patch series introduces a per-soc descriptor which should, in the
> end, contain most of the SoC specific operations.
> 
> This first patch series introduces the arm_soc_desc structure, adds
> per-soc SMP and CPU hotplug operations, and converts all SMP platform
> to this new scheme.
> 
> The last three patches consolidate some of the most commonly duplicated
> hotplug code and move it to a common location.
> 
> Patches against v3.3-rc2. Tested on VExpress (A5 and A15), RealView EB-11MP,
> OMAP4 (Panda) and Tegra2 (Harmony).
> 

Do you have a git tree for this?

Rob
