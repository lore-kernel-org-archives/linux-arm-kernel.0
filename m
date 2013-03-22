From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Mar 2013 15:45:45 +0000
Subject: [PATCH 1/5] ARM: ux500: Add machine support for ccu8540
In-Reply-To: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
References: <1363966065-2478-1-git-send-email-lee.jones@linaro.org>
Message-ID: <201303221545.45630.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 22 March 2013, Lee Jones wrote:
> Inform the kernel of a new machine type, so when detected it
> knows which initialisation route to travel though.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/mach-ux500/board-mop500.c |    9 +++++++++
>  arch/arm/tools/mach-types          |    1 +
>  2 files changed, 10 insertions(+)
> 

I'm not too happy to see another ATAGS based machine descriptor
in ux500. What is still missing for the DT boot?

	Arnd
