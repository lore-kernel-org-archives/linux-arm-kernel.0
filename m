From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Tue, 20 Aug 2013 11:56:05 +0300
Subject: [PATCH v2] clk: tegra: Correct sbc mux width & parent
In-Reply-To: <5203BB79.1000704@wwwdotorg.org>
References: <1375941327-4231-1-git-send-email-markz@nvidia.com>
 <5203BB79.1000704@wwwdotorg.org>
Message-ID: <20130820085605.GS18810@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 08, 2013 at 05:38:33PM +0200, Stephen Warren wrote:
> On 08/07/2013 11:55 PM, Mark Zhang wrote:
> > Tegra114 sbc1-sbc6 have more possible parent clocks than Tegra30.
> > So correct the parents and mux width for them.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>

Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Note that in downstream we intentionally leave out pllc2 and pllc3 as possible
parents for clocks which are not controlled using the cbus/shared clock
mechanism.

Cheers,

Peter.
