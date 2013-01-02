From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 15:09:58 -0700
Subject: [PATCH v2 00/11] Migrate Tegra to common clock framework
In-Reply-To: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50E4B036.6080205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/2012 07:47 AM, Prashant Gaikwad wrote:
> This patchset does following:
> 1. Decompose single tegra clock structure into multiple clocks.
> 2. Try to use standard clock types supported by common clock framework.
> 3. Use dynamic initialization.
> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
> 5. Add device tree support for Tegra20 and Tegra30 clocks.
> 6. Remove all legacy clock code from mach-tegra.

Mike,

Aside from a couple of small issues I just pointed out, this series
looks reasonable to me. I'd like to take it through the Tegra tree since
it might open up opportunities for other cleanup, and it has far more
dependencies-on/conflicts-with other changes there than the drivers/clk
tree. So, I'm looking for your ack when you can. Thanks.
