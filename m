From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 05 Jun 2013 10:25:24 -0600
Subject: [PATCH 0/2] PLL m,n,p init from SoC files
In-Reply-To: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <51AF6674.3020701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2013 07:51 AM, Peter De Schrijver wrote:
> The m,n,p fields don't have the same bit offset and width across all PLLs.
> This patchset allows SoC specific files to indicate the offset and width.
> It also provides the data for Tegra114.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
