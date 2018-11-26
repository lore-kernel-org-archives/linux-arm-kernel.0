From: gregkh@linuxfoundation.org (Greg KH)
Date: Mon, 26 Nov 2018 20:18:12 +0100
Subject: [PATCH 1/4] arm64: hyperv: Add core Hyper-V include files
In-Reply-To: <20181122031059.16338-1-kys@linuxonhyperv.com>
References: <20181122030914.16274-1-kys@linuxonhyperv.com>
 <20181122031059.16338-1-kys@linuxonhyperv.com>
Message-ID: <20181126191812.GA32208@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 03:10:56AM +0000, kys at linuxonhyperv.com wrote:
> --- /dev/null
> +++ b/arch/arm64/include/asm/hyperv-tlfs.h
> @@ -0,0 +1,338 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * This file contains definitions from the Hyper-V Hypervisor Top-Level
> + * Functional Specification (TLFS):
> + * https://na01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fdocs.microsoft.com%2Fen-us%2Fvirtualization%2Fhyper-v-on-windows%2Freference%2Ftlfs&amp;data=02%7C01%7Ckys%40microsoft.com%7Cc831a45fd63e4a4b083908d641216aa8%7C72f988bf86f141af91ab2d7cd011db47%7C1%7C0%7C636768009113747528&amp;sdata=jRSrs9ZWXdmeS7LQUEpoSyUfBS7a5KLYy%2FolFdE2tI0%3D&amp;reserved=0

"interesting" url :(

Care to use a real one?

thanks,

greg k-h
