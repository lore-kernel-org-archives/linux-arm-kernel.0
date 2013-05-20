From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 May 2013 11:47:21 -0600
Subject: [PATCH V2 3/4] ARM: tegra: convert device tree files to use GPIO
 defines
In-Reply-To: <1369069845-7601-1-git-send-email-swarren@wwwdotorg.org>
References: <1369069845-7601-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <519A61A9.2040407@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/2013 11:10 AM, Stephen Warren wrote:
> Use TEGRA_GPIO() macro to name all GPIOs referenced by GPIO properties,
> and some interrupts properties. Use standard GPIO flag defines too.

Applied (along with the reset of the series) to Tegra's for-3.11/dt branch.
