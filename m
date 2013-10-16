From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 16 Oct 2013 17:46:18 +0300
Subject: [PATCH v3 14/19] clk: tegra30: replace enum by binding header
In-Reply-To: <525D9A85.40102@wwwdotorg.org>
References: <1381848794-11761-1-git-send-email-pdeschrijver@nvidia.com>
 <1381848794-11761-15-git-send-email-pdeschrijver@nvidia.com>
 <525D9A85.40102@wwwdotorg.org>
Message-ID: <20131016144618.GL5643@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 15, 2013 at 09:41:57PM +0200, Stephen Warren wrote:
> On 10/15/2013 08:52 AM, Peter De Schrijver wrote:
> > As the clock IDs are now specified in a header file, we can use those
> > definitions instead of maintaining an internal enum.
> 
> Nit: The patch subject should say "clk: tegra:" not "clk: tegra20:" so
> that anyone looking at the tags in the subject has only one "tegra"
> value to look at, not a whole bunch of them.
> 
> Would it make sense to squash patches 15, 16, 18 together (and similar
> for Tegra30) to avoid some churn i.e. the fact that the entire body of
> tegra_periph_clk_list[] gets replaced twice?

You mean do all the changes for Tegra20 and Tegra30 in 1 patch per SoC?

Cheers,

Peter.
