From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 27 Jun 2014 15:18:33 +0300
Subject: [PATCH 5/6] clk: tegra: Add soctherm and tsensor clocks to
 Tegra124 init table
In-Reply-To: <1403856699-2140-6-git-send-email-mperttunen@nvidia.com>
References: <1403856699-2140-1-git-send-email-mperttunen@nvidia.com>
 <1403856699-2140-6-git-send-email-mperttunen@nvidia.com>
Message-ID: <20140627121833.GQ3679@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 10:11:38AM +0200, Mikko Perttunen wrote:
> This adds the two clocks, soctherm and tsensor, to the T124 initialization table.
> They are required for soctherm-based thermal sensing.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
> Peter, one more zero for TSENSOR, please :)

Ah :) I will take this into clk-tegra-3.17

Cheers,

Peter.
