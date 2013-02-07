From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 07 Feb 2013 13:29:09 -0800
Subject: [PATCH] clk: tegra30: fix wrong clock index between se to
 sata_cold
In-Reply-To: <5113FD1E.9020801@wwwdotorg.org>
References: <1360213631-16893-1-git-send-email-josephl@nvidia.com>
 <5113FD1E.9020801@wwwdotorg.org>
Message-ID: <20130207212909.11471.76375@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-02-07 11:14:38)
> On 02/06/2013 10:07 PM, Joseph Lo wrote:
> > The index of se should be 127. And the previous clock index was 125. So
> > we need to set up the index for se to get the correct index between se
> > to sata_cold.
> 
> I've applied this to Tegra's for-3.9/soc-ccf-fixes branch, on the
> assumption Mike is OK with it. I'll hold a pull request for his ack, and
> probably for a day or too in case any more clk-related fixes show up.

Acked-by: Mike Turquette <mturquette@linaro.org>
