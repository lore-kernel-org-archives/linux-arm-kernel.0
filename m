From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 13:41:57 -0600
Subject: [PATCH v3 14/19] clk: tegra30: replace enum by binding header
In-Reply-To: <1381848794-11761-15-git-send-email-pdeschrijver@nvidia.com>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-15-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <525D9A85.40102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> As the clock IDs are now specified in a header file, we can use those
> definitions instead of maintaining an internal enum.

Nit: The patch subject should say "clk: tegra:" not "clk: tegra20:" so
that anyone looking at the tags in the subject has only one "tegra"
value to look at, not a whole bunch of them.

Would it make sense to squash patches 15, 16, 18 together (and similar
for Tegra30) to avoid some churn i.e. the fact that the entire body of
tegra_periph_clk_list[] gets replaced twice?
