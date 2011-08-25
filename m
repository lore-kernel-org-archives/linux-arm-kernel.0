From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 25 Aug 2011 12:20:07 -0300
Subject: [[PATCH v2 6/6] ARM: mx5: use generic function for displaying
	silicon revision
In-Reply-To: <20110825145147.GX31404@pengutronix.de>
References: <1314162277-2840-1-git-send-email-jason.hui@linaro.org>
	<1314162277-2840-7-git-send-email-jason.hui@linaro.org>
	<20110825145147.GX31404@pengutronix.de>
Message-ID: <CAOMZO5DpoC6Wfd=rfYjcvPmAnNNtDBVytNa5Mvu+rgr2CebioA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha,

On Thu, Aug 25, 2011 at 11:51 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:

>> - ? ? if (rev == 0x0)
>> + ? ? switch (rev) {
>> + ? ? case 0x0:
>> ? ? ? ? ? ? ? return IMX_CHIP_REVISION_2_0;
>> - ? ? else if (rev == 0x10)
>> + ? ? case 0x2:
>> ? ? ? ? ? ? ? return IMX_CHIP_REVISION_3_0;
>
> 0x2 != 0x10
>
> My babbage board now shows a unknown cpu revision.

Just sent a patch to fix this.

Regards,

Fabio Estevam
