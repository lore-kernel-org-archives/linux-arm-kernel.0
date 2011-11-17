From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 17 Nov 2011 18:49:41 +0200
Subject: [PATCH v5 00/10] Add support for tegra30 and cardhu
In-Reply-To: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
References: <1321546766-26770-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20111117164941.GU19069@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 17, 2011 at 05:19:14PM +0100, Peter De Schrijver wrote:
> This patchset adds support for the tegra30 SoC and the cardhu development
> board.
> 
> Pathset is on top of Will Deacon's ARM reset work, my patch to convert tegra20
> to GIC devicetree binding and my patch to make clk_get not fatal.
> 

I just noticed the clk_get not fatal patch is already in linux-next.

Cheers,

Peter.
