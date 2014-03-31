From: b32955@freescale.com (Huang Shijie)
Date: Mon, 31 Mar 2014 10:06:59 +0800
Subject: [PATCHv3 1/2] mtd: gpmi: make blockmark swapping optional
In-Reply-To: <1396002907-17750-2-git-send-email-LW@KARO-electronics.de>
References: <1395235406-13449-1-git-send-email-y>
 <1396002907-17750-1-git-send-email-LW@KARO-electronics.de>
 <1396002907-17750-2-git-send-email-LW@KARO-electronics.de>
Message-ID: <20140331020657.GA32650@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 28, 2014 at 11:35:06AM +0100, Lothar Wa?mann wrote:
> +  - fsl,no-blockmark-swap: Don't swap the bad block marker from the OOB
> +                       area with the byte in the data area but rely on the
> +                       flash based BBT for identifying bad blocks.
> +                       NOTE: this is only valid in conjunction with
> +                             'nand-on-flash-bbt'.
> +                       WARNING: on i.MX28 blockmark swapping cannot be
> +                       disabled for the BootROM in the FCB. Thus,
> +                       partitions written from Linux with this feature
> +                       turned on may not be accessible by the BootROM
> +                       code.

Thanks for adding this warning.

Acked-by: Huang Shijie <b32955@freescale.com>


thanks
Huang Shijie
