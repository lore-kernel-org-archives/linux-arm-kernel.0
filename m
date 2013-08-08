From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 08 Aug 2013 15:32:44 -0700
Subject: [PATCH 1/3] clk: tegra114: Fix incorrect placement of __initdata
In-Reply-To: <5203E097.1040502@wwwdotorg.org>
References: <1375935949-19557-1-git-send-email-sachin.kamat@linaro.org>
 <5203E097.1040502@wwwdotorg.org>
Message-ID: <20130808223244.5348.4384@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Warren (2013-08-08 11:16:55)
> On 08/07/2013 10:25 PM, Sachin Kamat wrote:
> > __initdata should be placed between the variable name and equal
> > sign for the variable to be placed in the intended section.
> 
> The series,
> Acked-by: Stephen Warren <swarren@nvidia.com>
> 
> Patch 1,
> Tested-by: Stephen Warren <swarren@nvidia.com>
> 
> Mike, I assume you'll take these through the clock tree.

Done.

Regards,
Mike
