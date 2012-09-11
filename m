From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 11 Sep 2012 19:35:55 +0200
Subject: [PATCH 1/2] arm: mvebu: split Kconfig options for Armada 370
 and XP
In-Reply-To: <1347377834-19402-2-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1347266386-16229-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1347377834-19402-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1347377834-19402-2-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <504F767B.1050705@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 05:37 PM, Thomas Petazzoni wrote:
> A followup patch actually makes use of this split to select the
> appropriate pinctrl drivers.
 >
> [...]
 >
> +config MACH_ARMADA_370
> +	bool "Marvell Armada 370 boads"

typo: boards

> +	select MACH_ARMADA_370_XP
>   	help
> +	  Say 'Y' here if you want your kernel to support boards based
> +	  on the Marvell Armada XP SoC with device tree.

typo: Armada 370

>
> -	  Say 'Y' here if you want your kernel to support boards based on
> -	  Marvell Armada 370 or Armada XP with device tree.
> +config MACH_ARMADA_XP
> +	bool "Marvell Armada XP boards"
> +	select MACH_ARMADA_370_XP
> +	help
> +	  Say 'Y' here if you want your kernel to support boards based
> +	  on the Marvell Armada XP SoC with device tree.
>
>   endmenu

Sebastian
