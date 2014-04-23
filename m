From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 23 Apr 2014 10:22:25 -0600
Subject: [PATCH] ARM: tegra: remove TEGRA_EMC_SCALING_ENABLE
In-Reply-To: <1396889543-11896-1-git-send-email-swarren@wwwdotorg.org>
References: <1396889543-11896-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5357E8C1.4070409@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 10:52 AM, Stephen Warren wrote:
> From: Paul Bolle <pebolle@tiscali.nl>
> 
> Commit a7cbe92cef27 ("ARM: tegra: remove tegra EMC scaling driver")
> removed the only user of TEGRA_EMC_SCALING_ENABLE. Remove its Kconfig
> entry too.

arm-soc, I don't see this patch in linux-next yet.
