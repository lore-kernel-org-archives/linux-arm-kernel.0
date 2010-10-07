From: dwalker@codeaurora.org (Daniel Walker)
Date: Wed, 06 Oct 2010 18:00:04 -0700
Subject: [PATCH] ARM: Fix HWCAP_TLS flag for ARM11MPCore/Cortex-A9
In-Reply-To: <20101007000022.GD4859@atomide.com>
References: <20101007000022.GD4859@atomide.com>
Message-ID: <1286413204.22265.149.camel@m0nster>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 17:00 -0700, Tony Lindgren wrote:

> -	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
> +	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP|HWCAP_TLS


Thanks for catching this.. I have no idea how this happened, I must have
somehow been using a pre July 5th kernel when I made the patch.. Maybe a
forgotten bisect or something.

Daniel

-- 
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
