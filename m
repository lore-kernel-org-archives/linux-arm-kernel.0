From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 20 Aug 2013 11:47:58 +0300
Subject: [PATCH 4/5] clk: tegra: Set the clock parent of gr2d/gr3d to
 pll_c2
In-Reply-To: <1375874709-10438-4-git-send-email-markz@nvidia.com>
References: <1375874709-10438-1-git-send-email-markz@nvidia.com>
 <1375874709-10438-4-git-send-email-markz@nvidia.com>
Message-ID: <20130820084758.GR18810@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 07, 2013 at 01:25:08PM +0200, Mark Zhang wrote:
> pll_m will be the parent of gr2d/gr3d if we don't do this.
> And because pll_m runs at a high rate so gr2d/gr3d will be
> unstable. So change the parent of them to pll_c2.
> 
> Signed-off-by: Mark Zhang <markz@nvidia.com>

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>
