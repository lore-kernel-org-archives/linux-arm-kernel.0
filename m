From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 31 Jan 2011 17:53:53 -0200
Subject: [PATCH] ARM: mx5/board-mx53_evk.c: Make UART1 functional
In-Reply-To: <20110131193542.GU1147@pengutronix.de>
References: <1296493974-3817-1-git-send-email-fabio.estevam@freescale.com>
	<20110131193542.GU1147@pengutronix.de>
Message-ID: <4D471351.8030807@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

On 1/31/2011 5:35 PM, Uwe Kleine-K?nig wrote:
> On Mon, Jan 31, 2011 at 03:12:54PM -0200, Fabio Estevam wrote:
>> Fix UART1 IOMUX settings and configure UART1 to work with only RX/TX pins.
>>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> I cannot see a difference to the patch you sent ~5h earlier. ??

The first patch was targeted for MX53_SMD board. After having sent it I noticed that the MX53_EVK board also had the same issue, then I sent another one for fixing MX53_EVK console.

If you prefer I can combine the two patches into a single one.

Regards,

Fabio Estevam
