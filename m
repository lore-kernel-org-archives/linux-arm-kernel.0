From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 Oct 2013 16:31:35 -0600
Subject: [PATCH 4/5] clk: tegra124: Add new peripheral clocks
In-Reply-To: <1380878014-22088-5-git-send-email-pdeschrijver@nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-5-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525487C7.6080103@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2013 03:12 AM, Peter De Schrijver wrote:
> Tegra124 introduces a number of new peripheral clocks. This patch adds those
> to the common peripheral clock code.

Don't you need to add AFC[0..5] in this patch and/or patch 5?
