From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 21 Mar 2013 23:36:20 -0300
Subject: [PATCH 1/1 v2 net-next] net: fec: fix the build as module
In-Reply-To: <1363915193-22179-1-git-send-email-Frank.Li@freescale.com>
References: <1363915193-22179-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5D1p-QJ=7N-QrLbjcwK0b=280QEFuxNkbmYsmTeRitv+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:19 PM, Frank Li <Frank.Li@freescale.com> wrote:
> Since commit ff43da86c69 (NET: FEC: dynamtic check DMA desc buff type) the
> following build error happens when CONFIG_FEC=m
>
> ERROR: "fec_ptp_init" [drivers/net/ethernet/freescale/fec.ko] undefined!
> ERROR: "fec_ptp_ioctl" [drivers/net/ethernet/freescale/fec.ko] undefined!
> ERROR: "fec_ptp_start_cyclecounter" [drivers/net/ethernet/freescale/fec.ko] undefined!

This error does not not happen in 'net-next' anymore.
