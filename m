From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 27 Feb 2013 10:44:25 -0700
Subject: [PATCH V2 1/2] ARM: tegra: pmc: add specific compatible DT string
 for Tegra30 and Tegra114
In-Reply-To: <1361932063-13263-1-git-send-email-josephl@nvidia.com>
References: <1361932063-13263-1-git-send-email-josephl@nvidia.com>
Message-ID: <512E45F9.20108@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2013 07:27 PM, Joseph Lo wrote:
> The PMC HW is not 100% compatible across all Tegra series. We need to
> specify each of them in the DT match table.

Seems reasonable. I plan to apply for 3.10 when I can.
