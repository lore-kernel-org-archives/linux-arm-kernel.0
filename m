From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 5 Jun 2013 16:54:45 +0300
Subject: [PATCH 0/2] PLL m,n,p init from SoC files
In-Reply-To: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
References: <1370440301-3562-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130605135445.GP3847@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 03:51:24PM +0200, Peter De Schrijver wrote:
> The m,n,p fields don't have the same bit offset and width across all PLLs.
> This patchset allows SoC specific files to indicate the offset and width.
> It also provides the data for Tegra114.
> 

Depends on 'clk: tegra: pllc and pllxc should use pdiv_map'

Cheers,

Peter.
