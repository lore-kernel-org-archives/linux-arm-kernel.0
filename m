From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 14:01:51 -0600
Subject: [PATCH 2/2] ARM: dt: tegra: configure power off for some boards
In-Reply-To: <1347385427-9676-2-git-send-email-swarren@wwwdotorg.org>
References: <1347385427-9676-1-git-send-email-swarren@wwwdotorg.org>
 <1347385427-9676-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <504F98AF.2070500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 11:43 AM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> For Seaboard, Ventana, and Cardhu, add DT property to tell the regulator
> that it should provide the pm_power_off() implementation. This allows
> "shutdown" to work.

Applied to Tegra's for-3.7/dt branch.
