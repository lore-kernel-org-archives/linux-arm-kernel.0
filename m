From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 22 Mar 2013 10:05:18 -0600
Subject: [PATCH REPOST v2] clk: add table lookup to mux
In-Reply-To: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
References: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <514C813E.1070603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/22/2013 06:07 AM, Peter De Schrijver wrote:
> Add a table lookup feature to the mux clock. Also allow arbitrary masks
> instead of the width. This will be used by some clocks on Tegra114. Also
> adapt the tegra periph clk because it uses struct clk_mux directly.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Tested-by: Stephen Warren <swarren@nvidia.com>
