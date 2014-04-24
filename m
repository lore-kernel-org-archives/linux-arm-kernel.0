From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 24 Apr 2014 15:10:14 -0700
Subject: omap-serial: use mctrl_gpio helpers
In-Reply-To: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
References: <1398331471-16745-1-git-send-email-yegorslists@googlemail.com>
Message-ID: <20140424221014.GA29114@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 24, 2014 at 11:24:30AM +0200, yegorslists at googlemail.com wrote:
> This patch is based on Richard Genoud' patch adding generic GPIO support [1]
> and my patch adding get_direction() functionality to OMAP's GPIO driver [2].
> 
> So far RTS/DTR are working both as modem control outputs and RTS as RS-485 2-wire controller.
> 
> CTS/DSR/DSR/RI are generating interrupts.
> 
> Richard, Greg, what is the status of [1]? It seems like it will be available in 3.16 first?

Probably.
