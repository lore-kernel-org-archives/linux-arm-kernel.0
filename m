From: davidb@codeaurora.org (David Brown)
Date: Mon, 24 Sep 2012 10:40:54 -0700
Subject: [PATCH] ARM: dtb: move all dtb targets to common Makefile
In-Reply-To: <1348203840-23559-1-git-send-email-olof@lixom.net>
References: <1348203840-23559-1-git-send-email-olof@lixom.net>
Message-ID: <20120924174054.GA8290@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 10:04:00PM -0700, Olof Johansson wrote:
> Since the dtb targets have moved to arch/arm/boot/dts/Makefile, sweep
> the platforms that have had new targets added recently and move them over.
> 
> While I was at it, I also made the dtb generation more generic, i.e. if
> the platform is enabled then all dtbs for that platform will be created.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: David Brown <davidb@codeaurora.com>
> Cc: Barry Song <Baohua.Song@csr.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> ---
> 
> Already applied to next/multiplatform.
> 
>  arch/arm/mach-msm/Makefile.boot      |  3 ---

Acked-by: David Brown <davidb@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
