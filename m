From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 29 Jan 2011 15:05:50 -0200
Subject: [PATCH 1/1] ARM: imx53_loco: add all pad configure.
In-Reply-To: <20110129141112.GA3483@richard-laptop>
References: <1296298099-16611-1-git-send-email-richard.zhao@freescale.com>
	<AANLkTimZqS+WkxerdkH_dPBX9_=5qn=fwWP6u-y=xYer@mail.gmail.com>
	<20110129141112.GA3483@richard-laptop>
Message-ID: <AANLkTiktMZ6K1Vx1JFFyJOr6FmnEwaV8DPkAnHT=XMho@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 29, 2011 at 12:11 PM, Richard Zhao <linuxzsc@gmail.com> wrote:
> On Sat, Jan 29, 2011 at 11:31:38AM -0200, Fabio Estevam wrote:
>> Hi Richard,
>>
>> On Sat, Jan 29, 2011 at 8:48 AM, Richard Zhao <linuxzsc@gmail.com> wrote:
>> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
>> >
>> > diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
>> > index 3aefd6d..d724ac8 100644
>> > --- a/arch/arm/mach-mx5/board-mx53_loco.c
>> > +++ b/arch/arm/mach-mx5/board-mx53_loco.c
>> > @@ -39,8 +39,145 @@
>> > ?#define LOCO_FEC_PHY_RST ? ? ? ? ? ? ? IMX_GPIO_NR(7, 6)
>>
>> Don?t you also need to define the PAD_CTRL settings for the different
>> peripherals in iomux-53.h?
> Dinh is doing the SoC level work. I don't think I need to repeat the effort.

Then don?t you think it is better to add the board level IOMUX after
Dinh?s work?

Regards,

Fabio Estevam
