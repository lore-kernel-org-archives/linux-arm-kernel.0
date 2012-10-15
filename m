From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 15 Oct 2012 11:39:56 -0600
Subject: [PATCH] ARM: tegra: update *.dts for regulator-compatible
 deprecation
In-Reply-To: <1349204824-21758-1-git-send-email-swarren@wwwdotorg.org>
References: <1349204824-21758-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <507C4A6C.4050705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/02/2012 01:07 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Commit 13511de "regulator: deprecate regulator-compatible DT property"
> now allows for simpler content within the regulators node within a PMIC.
> Modify all the Tegra device tree files to take advantage of this.

Applied to Tegra's for-3.8/cleanup.
