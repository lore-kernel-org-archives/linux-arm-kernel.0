From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 4 Sep 2013 08:54:26 +0800
Subject: [PATCH 4/4] clk: tegra114: table driven PMC clock init
In-Reply-To: <1378215105-12145-5-git-send-email-pdeschrijver@nvidia.com>
References: <1378215105-12145-1-git-send-email-pdeschrijver@nvidia.com>
 <1378215105-12145-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <1378256066.10742.1.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-09-03 at 21:31 +0800, Peter De Schrijver wrote:
> This patch converts the Tegra114 audio clock registration to be table driven
> like the periph clocks.
s/audio/PMC/ :)
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> ---
>  drivers/clk/tegra/clk-tegra114.c |   58 +++++++++++++++-----------------------
>  1 files changed, 23 insertions(+), 35 deletions(-)
> 
[snip]
