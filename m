From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 11 Nov 2011 18:48:30 -0200
Subject: [PATCH v2] ARM: mx28evk: Simplify GPIO requests for
 mx28evk_fec_reset
In-Reply-To: <20111110075446.GR16886@pengutronix.de>
References: <1320870998-6200-1-git-send-email-festevam@gmail.com>
 <20111109214603.GA6316@pengutronix.de>
 <20111110075446.GR16886@pengutronix.de>
Message-ID: <CAOMZO5DOA64OmHEn0FnqtL71FztYC9Vp=3wCDrZY+f7b8dRwzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 5:54 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Wed, Nov 09, 2011 at 10:46:03PM +0100, Wolfram Sang wrote:
>> On Wed, Nov 09, 2011 at 06:36:38PM -0200, Fabio Estevam wrote:
>> > From: Fabio Estevam <fabio.estevam@freescale.com>
>> >
>> > Simplify GPIO requests inside mx28evk_fec_reset by using gpio_request_array.
>> >
>> > Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>
>> Like it: Acked-by: Wolfram Sang <w.sang@pengutronix.de>
>
> /me not. See my comments to v1.

Ok, I will implement your suggestion in v3.

Will wait Shawn?s patch "arm/mxs: fix mmc device adding for
mach-mx28evk" to reach rc2 first.

Regards,

Fabio Estevam
