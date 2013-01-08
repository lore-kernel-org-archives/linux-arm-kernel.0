From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Tue, 8 Jan 2013 10:55:26 +0100
Subject: [PATCH 1/1 net-next] net: fec: enable pause frame to improve
 rx prefomance for 1G network
In-Reply-To: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
References: <1357634609-4112-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <50EBED0E.6090608@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.01.2013 09:43, Frank Li wrote:
> The limition of imx6 internal bus cause fec can't achieve 1G perfomance.
> There will be many packages lost because FIFO over run.
> 
> This patch enable pause frame flow control.

Many thanks for this patch!

Do we want/need anything similar for U-Boot, too?

Some people want to boot the system from U-Boot attached to 1G network 
and have issues there, too.

Best regards

Dirk
