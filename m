From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 11 Apr 2011 10:15:12 -0700
Subject: [PATCH] ARM: Kconfig.debug: Remove unused CONFIG_DEBUG_ERRORS
In-Reply-To: <alpine.LNX.2.00.1104101904000.17706@swampdragon.chaosbits.net>
References: <1302300518-7523-1-git-send-email-sboyd@codeaurora.org>
	<alpine.LNX.2.00.1104101904000.17706@swampdragon.chaosbits.net>
Message-ID: <4DA33720.5020206@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> But, I see a lot of *_defconfig files in my copy of the tree that 
> reference the option :
>
[snip]
> shouldn't those lines be removed as well?
>
> I can submit a patch, but I thought you'd rather do it yourself..
>

I was concerned that it would be more churn in the defconfigs. I can
make a patch for that too though. Or we could just wait for the
defconfigs to be regenerated and then the symbols would be dropped?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
