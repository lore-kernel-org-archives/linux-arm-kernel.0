From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Apr 2014 10:24:47 -0600
Subject: [PATCH 2/3] clk: tegra: remove non-existent clocks
In-Reply-To: <1396383197-5979-2-git-send-email-swarren@wwwdotorg.org>
References: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
 <1396383197-5979-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5357E94F.7000408@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/01/2014 02:13 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra124 clock driver currently provides 3 clocks that don't actually
> exist; 2 for NAND and one for UART5/UARTE. Delete these.

Mike, are you OK with this patch? Can I get your ack so this patch can
be taken into a branch with a couple other patches that it depends or or
depend on it.

arm-soc, I was hoping this whole series would get applied for 3.15
through the arm-soc tree. Is there any issue with that?
