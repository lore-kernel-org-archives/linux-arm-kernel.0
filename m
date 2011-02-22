From: cjb@laptop.org (Chris Ball)
Date: Tue, 22 Feb 2011 15:26:53 +0000
Subject: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
In-Reply-To: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <20110222152653.GA6563@void.printf.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> The driver calls into mxs-dma via generic dmaengine api for both pio
> and data transfer.

Thanks very much, pushed to mmc-next for .39.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
