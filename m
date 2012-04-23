From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 23 Apr 2012 10:31:22 -0600
Subject: [PATCH] ARM: tegra: Initialize pll_p_out1
In-Reply-To: <1335169910-29403-1-git-send-email-pdeschrijver@nvidia.com>
References: <1335169910-29403-1-git-send-email-pdeschrijver@nvidia.com>
Message-ID: <4F9583DA.2090107@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2012 02:31 AM, Peter De Schrijver wrote:
> pll_a uses pll_p_out1 as its parent. Therefore this clock needs to be
> initialized to make sure pll_a has a known input clock. Failure to do so
> will cause the system to crash early in the bootup.
> 
> Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>

Thanks, applied.

> --
> 
> Changes in v2:


BTW, that "--" needs to be "---" if you don't intend the changelog to
end up in git when I apply the patch.
