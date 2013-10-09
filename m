From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Wed, 9 Oct 2013 11:11:23 +0300
Subject: [PATCH 4/5] clk: tegra124: Add new peripheral clocks
In-Reply-To: <525487C7.6080103@wwwdotorg.org>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-5-git-send-email-pdeschrijver@nvidia.com>
 <525487C7.6080103@wwwdotorg.org>
Message-ID: <20131009081123.GB3973@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 12:31:35AM +0200, Stephen Warren wrote:
> On 10/04/2013 03:12 AM, Peter De Schrijver wrote:
> > Tegra124 introduces a number of new peripheral clocks. This patch adds those
> > to the common peripheral clock code.
> 
> Don't you need to add AFC[0..5] in this patch and/or patch 5?

AFC[0..5] are reset only nodes afaik. Up to now, we haven't done that.
The goal is to include them once we move to the reset framework.

Cheers,

Peter.
