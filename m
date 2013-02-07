From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 12:14:38 -0700
Subject: [PATCH] clk: tegra30: fix wrong clock index between se to
 sata_cold
In-Reply-To: <1360213631-16893-1-git-send-email-josephl@nvidia.com>
References: <1360213631-16893-1-git-send-email-josephl@nvidia.com>
Message-ID: <5113FD1E.9020801@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2013 10:07 PM, Joseph Lo wrote:
> The index of se should be 127. And the previous clock index was 125. So
> we need to set up the index for se to get the correct index between se
> to sata_cold.

I've applied this to Tegra's for-3.9/soc-ccf-fixes branch, on the
assumption Mike is OK with it. I'll hold a pull request for his ack, and
probably for a day or too in case any more clk-related fixes show up.
