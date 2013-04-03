From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 03 Apr 2013 12:10:11 -0600
Subject: [PATCH v9 12/14] clk: tegra: devicetree match for nvidia,
 tegra114-car
In-Reply-To: <1365000110-8916-13-git-send-email-pdeschrijver@nvidia.com>
References: <1365000110-8916-1-git-send-email-pdeschrijver@nvidia.com>
 <1365000110-8916-13-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <515C7083.9070702@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 08:40 AM, Peter De Schrijver wrote:
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

I see this patch does depend on my "clk: tegra: defer application of
init table", although my patch was based on top of this series so needs
to be adjusted to remove the Tegra114 portions so it can be applied first.
