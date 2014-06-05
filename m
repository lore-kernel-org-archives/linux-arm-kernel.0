From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 09:51:53 -0600
Subject: [PATCH 1/3] ARM: dts: Create a cros-ec-keyboard fragment
In-Reply-To: <1401920421-25729-1-git-send-email-dianders@chromium.org>
References: <1401920421-25729-1-git-send-email-dianders@chromium.org>
Message-ID: <53909219.6090200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/2014 04:20 PM, Doug Anderson wrote:
> All ChromeOS ARM devices that have the standard "CrOS EC" have the
> same keyboard mapping.  It's silly to include this same definition
> everywhere.  Let's create a "dtsi" fragment that we can include from
> many different boards.
> 
> This fragment is based on what's currently in tegra124-venice2.dts

This series looks fine to me. Given it touches both Tegra and Exynos,
should it be merged into a topic branch in arm-soc, so that it can be
pulled into both Tegra/Exynos trees to resolve any conflicts. So,

Acked-by: Stephen Warren <swarren@nvidia.com>

If you want, I'm happy to apply this to a topic branch and send a pull
request to arm-soc.
