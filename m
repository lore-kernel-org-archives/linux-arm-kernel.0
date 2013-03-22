From: mturquette@linaro.org (Mike Turquette)
Date: Fri, 22 Mar 2013 13:25:22 -0700
Subject: [PATCH REPOST v2] clk: add table lookup to mux
In-Reply-To: <514C813E.1070603@wwwdotorg.org>
References: <1363954078-29952-1-git-send-email-pdeschrijver@nvidia.com>
 <514C813E.1070603@wwwdotorg.org>
Message-ID: <20130322202522.834.24639@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-03-22 09:05:18)
> On 03/22/2013 06:07 AM, Peter De Schrijver wrote:
> > Add a table lookup feature to the mux clock. Also allow arbitrary masks
> > instead of the width. This will be used by some clocks on Tegra114. Also
> > adapt the tegra periph clk because it uses struct clk_mux directly.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> 
> Tested-by: Stephen Warren <swarren@nvidia.com>

Thanks for the patch.  Taken into clk-next.

Regards,
Mike
