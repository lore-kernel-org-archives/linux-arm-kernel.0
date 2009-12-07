From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 7 Dec 2009 19:22:29 +0100
Subject: MXC: MC13783 Voltage regulation full support
In-Reply-To: <1260199017.2166.14.camel@climbing-alby>
References: <1260199017.2166.14.camel@climbing-alby>
Message-ID: <20091207182229.GA25509@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alberto,

On Mon, Dec 07, 2009 at 04:16:57PM +0100, Alberto Panizzo wrote:
> Hi! I am working on imx31pdk board support.
> 
> This board use strongly the power management chip Freescale MC13783
> to set and enable power supply to devices, so a complete regulator 
> driver for this chip is needed.
> 
> I ask you, anyone is working on this task now?
> 
> Or are there some problems pending that explain why the present driver
> can only enable or disable regulators? 
I think the only problem was that Sascha havn't had the need for full
regulators and so didn't invest the time.  Note that the driver changed
in next if you plan to send patches.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
