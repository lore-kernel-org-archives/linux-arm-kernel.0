From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 01 May 2014 10:45:46 -0600
Subject: [PATCH] ARM: tegra: remove UART5/UARTE from tegra124.dtsi
In-Reply-To: <1398962608-11867-1-git-send-email-swarren@wwwdotorg.org>
References: <1398962608-11867-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <53627A3A.80504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/01/2014 10:43 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> (This is commit 862f0eea38409ff0d7f226c1245b787e3f0e2607 upstream)
> 
> Tegra124 only has 4 UARTs. Parts of the documentation hint at a fifth
> UART, but this appears to be left-over from earlier SoC documentation.
> Remove the non-existent DT node for UART5.
> 
> Cc: <stable@vger.kernel.org> # v3.14
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is a backport of the upstream commit specifically for 3.13.

Sorry for the confusion; this patch really is for 3.14 just like the Cc:
stable tag above says.
