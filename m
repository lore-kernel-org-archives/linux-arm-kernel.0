From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 07 Feb 2013 14:57:31 -0700
Subject: [PATCH] ARM: smp_twd: convert to use CLKSRC_OF init
In-Reply-To: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
References: <1360270385-24335-1-git-send-email-robherring2@gmail.com>
Message-ID: <5114234B.20003@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/07/2013 01:53 PM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Now that we have OF based init with CLKSRC_OF, convert smp_twd init
> function to use it and covert all callers of
> twd_local_timer_of_register.

Reviewed-by: Stephen Warren <swarren@nvidia.com>

Thanks for cleaning these up. I really should have gone through all the
timer objects and converted them when I implemented the CLKSRC_OF
feature in the first place.
