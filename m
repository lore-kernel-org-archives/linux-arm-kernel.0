From: tobetter@gmail.com (Dongjin Kim)
Date: Sat, 26 Jan 2013 15:06:53 +0900
Subject: [PATCH RESEND] ARM: dts: max77686: Add DTS file for max77686 PMIC
In-Reply-To: <20130126050618.GD10580@opensource.wolfsonmicro.com>
References: <1359053177-17725-1-git-send-email-tobetter@gmail.com>
 <20130126050618.GD10580@opensource.wolfsonmicro.com>
Message-ID: <CADoNuNeF_fw1uuMt89=gZm-A2R6FHGpr-kCgFkOY0xXpA9+Jzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

Yes, this is not ARM-specific chip at all. Just wanted to be reviewed
by you and others if the format is ok before integrating to my board
file. I had sent similar one before,
https://patchwork.kernel.org/patch/1287711, and you advised that was
too board specific. And plan to integrate like OMAP boards have with
twl6030.dtsi and twl6040.dtsi.

If would be nice if somewhere you specify a directory for such device files.

Regards,
Dongjin.

On Sat, Jan 26, 2013 at 2:06 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jan 25, 2013 at 03:46:08AM +0900, Dongjin Kim wrote:
>
>> ---
>>  arch/arm/boot/dts/max77686.dtsi |  156 +++++++++++++++++++++++++++++++++++++++
>
> Why is this in arch/arm?  This isn't an ARM-specific chip.
