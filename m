From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 11:30:18 -0600
Subject: [PATCH] ARM: Fix dts files w/ status property: "disable" ->
 "disabled"
In-Reply-To: <1339427460-23007-1-git-send-email-stigge@antcom.de>
References: <1339427460-23007-1-git-send-email-stigge@antcom.de>
Message-ID: <4FD62B2A.2030600@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2012 09:11 AM, Roland Stigge wrote:
> This patches fixes some status = "disable" strings to "disabled", the correct
> way of disabling nodes in the devicetree.
> 
> lpc32xx.dtsi is fixed separately in the LPC32xx patch set due to the many
> changes there.

The Tegra parts,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>

Are you intending this to be applied for 3.5? If so, that's fine. If
not, splitting it up so I can take the Tegra parts through the Tegra
tree would reduce the possibility of conflicts.
