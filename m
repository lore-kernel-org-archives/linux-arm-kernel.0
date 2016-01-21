From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jan 2016 09:26:42 +0100
Subject: [RFC 2/9] clk: bcm2835: add support for parent selection in DT
In-Reply-To: <1453215100-2382-3-git-send-email-kernel@martin.sperl.org>
References: <1453215100-2382-1-git-send-email-kernel@martin.sperl.org>
 <1453215100-2382-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <20160121082642.GB13237@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin,

On Tue, Jan 19, 2016 at 02:51:33PM +0000, kernel at martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Allow for a per clock custom selection of clocks in the device tree.
> 
> Basic setup in dt looks like this:
>   clock at BCM2835_CLOCK_PCM {
>     reg = <BCM2835_CLOCK_PCM>;
>     parent-clock-names = "xosc", "plld_per", "plla_per", "pll_aux_per";
>   };

Isn't this the same as the already existing assigned-clock-parents property?
If yes, that should be used.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
