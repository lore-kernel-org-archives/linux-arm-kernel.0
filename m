From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 2 Apr 2014 11:10:33 +0300
Subject: [PATCH 2/3] clk: tegra: remove non-existent clocks
In-Reply-To: <1396383197-5979-2-git-send-email-swarren@wwwdotorg.org>
References: <1396383197-5979-1-git-send-email-swarren@wwwdotorg.org>
 <1396383197-5979-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20140402081033.GL2931@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 01, 2014 at 10:13:16PM +0200, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Tegra124 clock driver currently provides 3 clocks that don't actually
> exist; 2 for NAND and one for UART5/UARTE. Delete these.
> 
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

Cheers,

Peter.
