From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Fri, 22 Mar 2013 14:09:20 +0200
Subject: [PATCH] clk: tegra: Don't enable PLLs during early boot
In-Reply-To: <1363953762-29783-1-git-send-email-pdeschrijver@nvidia.com>
References: <1363953762-29783-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <20130322120920.GW18519@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 22, 2013 at 01:02:33PM +0100, Peter De Schrijver wrote:
> The PLL code relies on udelay() which is not available when CCF is
> initialized. Hence we can't enable any PLL during this phase.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 

Sorry for accidently reposting this.

Cheers,

Peter.
