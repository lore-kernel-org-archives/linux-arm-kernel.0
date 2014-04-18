From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Fri, 18 Apr 2014 09:20:56 +0200
Subject: [PATCH 1/4] mmc: sdhci: add a driver for Berlin SoCs
In-Reply-To: <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-2-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140418072056.GB26909@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Wed, Apr 16, 2014 at 02:40:08PM +0200, Antoine T?nart wrote:
> Add a Driver to support the SDHCI controller of the Marvell Berlin SoCs.
> This controller supports 3 sockets.

After talking a bit with Sebastian and Jisheng I decided to have a look on the
pxav3 driver. I gave it a try, it seemed to be compatible with the Berlin SDHCI
controller so I'll use this one instead of adding a Berlin specific one.

You all can forget this one, I'll send a v2 using the pxav3 driver.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
