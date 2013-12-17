From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Dec 2013 16:02:44 -0700
Subject: [PATCH 4/4] clk: tegra20: enable EMC clock driver
In-Reply-To: <1387272400-4689-5-git-send-email-josephl@nvidia.com>
References: <1387272400-4689-1-git-send-email-josephl@nvidia.com>
 <1387272400-4689-5-git-send-email-josephl@nvidia.com>
Message-ID: <52B0D814.8040208@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/17/2013 02:26 AM, Joseph Lo wrote:
> Re-register the EMC clock to the EMC clock driver in the Tegra CCF
> driver to support EMC scaling.

Can't this be squashed into patch 2/4?
