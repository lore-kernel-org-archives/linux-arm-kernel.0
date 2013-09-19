From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Sep 2013 12:26:13 -0600
Subject: [PATCH REPOST] ARM: tegra: use dt-binding header for key code
In-Reply-To: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
References: <1379510552-23401-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <523B41C5.1050905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2013 07:22 AM, Laxman Dewangan wrote:
> In place of hardcoding the key code in DTS file and comment the
> key code as side notes, use the key code macro defines in the
> dt-bindings/input/input.h directly.

Applied to Tegra's for-3.13/dt branch.
