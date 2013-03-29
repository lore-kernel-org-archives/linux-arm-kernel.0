From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 29 Mar 2013 16:04:04 -0600
Subject: [PATCH 1/1] ARM: boot/dts/Makefile: drop '\'
In-Reply-To: <1364584776-30413-1-git-send-email-plagnioj@jcrosoft.com>
References: <1364584776-30413-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <51560FD4.6080206@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/29/2013 01:19 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> when adding multiple new platform this generate comflict
> so drop it

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile

> +# tegra
> +# trega20
> +# trega30
> +# trega114

3 typos there, but otherwise this is probably fine.
