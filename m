From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 17 Sep 2014 16:41:55 +0300
Subject: [PATCH 3/8] ARM: tegra: Add PLL_M_UD and PLL_C_UD to
 tegra124-car binding header
In-Reply-To: <53FB7564.7020304@wwwdotorg.org>
References: <1405088313-20048-1-git-send-email-mperttunen@nvidia.com>
 <1405088313-20048-4-git-send-email-mperttunen@nvidia.com>
 <53FB7564.7020304@wwwdotorg.org>
Message-ID: <20140917134155.GJ26779@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 25, 2014 at 07:41:56PM +0200, Stephen Warren wrote:
> On 07/11/2014 08:18 AM, Mikko Perttunen wrote:
> > Add these clocks to the binding header so that EMC timings that have
> > them as parent can refer to the clocks.
> 
> Peter, I assume this patch (and patch 4/8 too) will be needed by any EMC 
> driver, whether it's part of this series or Tomeu Vizoso's work. Can you 
> please review/ack those two patches for later reference. Thanks.

Looks ok to me. I will take them in tegra-clk-next
