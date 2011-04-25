From: greg@kroah.com (Greg KH)
Date: Mon, 25 Apr 2011 14:20:56 -0700
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <20110425212056.GA29313@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 22, 2011 at 05:38:26PM +0530, Subhasish Ghosh wrote:
> This patch adds support for the TTY compliant
> Soft-UART device emulated on PRUSS.
> 
> This patch depends on:
> davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS.
>             https://patchwork.kernel.org/patch/615681/
> davinci: changed SRAM allocator to shared ram.
>             https://patchwork.kernel.org/patch/549351/

Who is going to be applying these patches to the tree?

Should this driver go through a davinci subtree because of these
dependancies?

thanks,

greg k-h
