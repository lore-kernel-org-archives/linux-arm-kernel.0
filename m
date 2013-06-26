From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 26 Jun 2013 13:40:08 -0600
Subject: [PATCH 09/11] ARM: tegar: remove the limitation that Tegra114
 can't support suspend
In-Reply-To: <1372152475-18617-10-git-send-email-josephl@nvidia.com>
References: <1372152475-18617-1-git-send-email-josephl@nvidia.com>
 <1372152475-18617-10-git-send-email-josephl@nvidia.com>
Message-ID: <51CB4398.8050900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/2013 03:27 AM, Joseph Lo wrote:
> The Tegra114 can support suspend function now, removing the limitation.

OK, so this is the first point at which system suspend is enabled on
Tegra114. However, some of the changes in earlier patches sounded like
the might affect, or be required by, cpuidle too. Is that the case? If
so, can you assure me that bisectability of Tegra114 cpuidle is
maintained across this whole series?
