From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 19 Nov 2014 15:29:19 -0200
Subject: [PATCH] dma: imx-sdma: clarify about firmware not found error
In-Reply-To: <20141117075456.GD30369@pengutronix.de>
References: <1415829869-6661-1-git-send-email-festevam@gmail.com>
 <20141117075456.GD30369@pengutronix.de>
Message-ID: <CAOMZO5A98yvSEUEEEEEN=eacXpjFvoLcs2xhdW9dabH3S=FB3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vinod,

On Mon, Nov 17, 2014 at 5:54 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Nov 12, 2014 at 08:04:29PM -0200, Fabio Estevam wrote:
>> From: Sascha Hauer <s.hauer@pengutronix.de>
>>
>> When a firmware cannot be found for the SDMA engine then we can
>> continue with the internal ROM firmware.
>>
>> The meaning of this message is frequently asked for, so make clear
>> that the driver still works with the internal ROM firmware and reduce
>> the loglevel from err to info.
>>
>> Cc: Vinod Koul <vinod.koul@intel.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: Shawn Guo <shawn.guo@linaro.org>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>
> I still think we should have this.
>
> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

Could this one be applied?
