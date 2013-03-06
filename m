From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Mar 2013 14:45:59 -0700
Subject: [PATCH V2 1/2] ARM: tegra: pmc: add specific compatible DT string
 for Tegra30 and Tegra114
In-Reply-To: <1361932063-13263-1-git-send-email-josephl@nvidia.com>
References: <1361932063-13263-1-git-send-email-josephl@nvidia.com>
Message-ID: <5137B917.20803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:27 PM, Joseph Lo wrote:
> The PMC HW is not 100% compatible across all Tegra series. We need to
> specify each of them in the DT match table.

I have applied these two patches to Tegra's for-3.10/cleanup branch.
