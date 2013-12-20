From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 19 Dec 2013 18:46:09 -0800
Subject: [PATCH] clk: tegra: Add missing Tegra20 fuse clks
In-Reply-To: <52B3478A.2030405@wwwdotorg.org>
References: <1387469676-17693-1-git-send-email-pdeschrijver@nvidia.com>
 <52B3478A.2030405@wwwdotorg.org>
Message-ID: <20131220024609.18119.76686@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-12-19 11:22:50)
> On 12/19/2013 09:14 AM, Peter De Schrijver wrote:
> 
> A patch description would be nice.
> 
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> I assume this is going through the clock tree, and there aren't any
> dependencies between this patch and the other series touching fuses that
> showed up today? (or the dependencies will be resolved by deferring
> dependant patches to 3.15...)
> 

Acked-by: Mike Turquette <mturquette@linaro.org>

Quick note: now that we're using pull requests for the Nvidia clock
patches I'll just Ack patches that look good to me and at some point
I'll expect that patch to wind up in a future pull request.

If you just want me to take the patch directly it is no problem but
please let me know explicitly.

Thanks!
Mike
