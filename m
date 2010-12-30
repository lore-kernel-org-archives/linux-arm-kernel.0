From: richard.zhao@freescale.com (Richard Zhao)
Date: Thu, 30 Dec 2010 17:29:41 +0800
Subject: [PATCH v3 6/8] arm: mx50: add core functions support except clock
In-Reply-To: <1293684968-7338-6-git-send-email-richard.zhao@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-3-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-4-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-5-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-6-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101230092939.GA25314@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]
> diff --git a/arch/arm/plat-mxc/include/mach/mx50.h b/arch/arm/plat-mxc/include/mach/mx50.h
> new file mode 100644
> index 0000000..f8ba445
> --- /dev/null
> +++ b/arch/arm/plat-mxc/include/mach/mx50.h
[...]
> +#define MX50_MXC_FEC_BASE_ADDR	(MX50_AIPS2_BASE_ADDR + 0x000ec000)
It's MX50_FEC_BASE_ADDR. Sorry for that.
I'm add fec support.

Thanks
Richard
