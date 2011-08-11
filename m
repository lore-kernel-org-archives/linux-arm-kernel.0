From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 11 Aug 2011 15:31:24 +0200
Subject: [RFC PATCH 7/8] ARM: ux500: convert logical CPU numbers to
	physical numbers
In-Reply-To: <1312926162-22469-8-git-send-email-will.deacon@arm.com>
References: <1312926162-22469-1-git-send-email-will.deacon@arm.com>
	<1312926162-22469-8-git-send-email-will.deacon@arm.com>
Message-ID: <4E43D9AC.2010509@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/09/2011 11:42 PM, Will Deacon wrote:
> This patch uses the new cpu_logical_map() macro for converting logical
> CPU numbers into physical numbers when dealing with the pen_release
> variable in the SMP boot and CPU hotplug paths.
>
> Cc: Linus Walleij<linus.walleij@stericsson.com>
> Signed-off-by: Will Deacon<will.deacon@arm.com>
>    

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!
Linus Walleij
