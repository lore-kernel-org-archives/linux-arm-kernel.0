From: mgr@pengutronix.de (Michael Grzeschik)
Date: Mon, 16 Aug 2010 15:58:31 +0200
Subject: [PATCH 1/4] clock-imx35: use get_3_3_div helper for
	get_rate_ipg_per
In-Reply-To: <4C693F2C.6060605@ru.mvista.com>
References: <1281964473-27484-1-git-send-email-m.grzeschik@pengutronix.de>
	<1281964473-27484-2-git-send-email-m.grzeschik@pengutronix.de>
	<4C693F2C.6060605@ru.mvista.com>
Message-ID: <20100816135831.GA1060@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 16, 2010 at 05:37:48PM +0400, Sergei Shtylyov wrote:
> Hello.
>
> Michael Grzeschik wrote:
>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>    So, who's the author of the patch? In case it's actually Marc, you 
> should have added (at the start of the changelog):
>
> From: Marc Kleine-Budde <mkl@pengutronix.de>
Done that, sorry Marc and Juergen, was not trying to take credit ;-)

Thanks,
Michael

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
