From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Jun 2013 11:44:41 -0600
Subject: [PATCH 4/4] arm: tegra: Add power-supplies link between battery
 and charger
In-Reply-To: <1370899602-22123-5-git-send-email-rklein@nvidia.com>
References: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
 <1370899602-22123-5-git-send-email-rklein@nvidia.com>
Message-ID: <51B8B389.8010105@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/10/2013 03:26 PM, Rhyland Klein wrote:
> The power supply core now supports detecting linkages between batteries
> and chargers through the use of the power-supplies property. Adding
> this to the battery, the core will use the phandle list to find
> the associated charger and pair them up. This facilitates notifications
> from the charger to the battery when ac power is dissconnected
> or connected for instance.

Rhyland, if I apply this patch without patches 1-3 being in the same
branch, will it cause any bugs? If so, I guess 1-3 should go through the
drivers/power maintainer for 3.11, and I should defer this patch to 3.12?
