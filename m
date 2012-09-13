From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Sep 2012 09:57:51 -0600
Subject: [PATCH] ARM: Tegra: Add smp_twd clock for Tegra20
In-Reply-To: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
References: <1347528873-3799-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <5052027F.1000404@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 03:34 AM, Prashant Gaikwad wrote:
> Clockevent's frequency is changed upon cpufreq change
> notification. It fetches local timer's rate to update the
> clockevent frequency. This patch adds local timer clock
> for Tegra20.

Hmm. Off-list, I'd asked you to check whether this patch, and Mike's
twd/clk-notifier changes were OK for Tegra, and part of your reponse was:

Tegra20 (Ventana)
        Tegra's for-next (common clock) + smp_twd : Panic

Is that true? If so, I can't apply this patch...
