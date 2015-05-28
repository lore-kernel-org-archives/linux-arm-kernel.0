From: lznuaa@gmail.com (Zhi Li)
Date: Thu, 28 May 2015 08:18:24 -0500
Subject: [PATCH v5 0/6] Change snvs rtc and poweroff to use syscon add
 pwrkey driver
In-Reply-To: <20150528121353.GP2185@piout.net>
References: <1432657562-5592-1-git-send-email-Frank.Li@freescale.com>
 <20150527121052.GH16165@dragon> <20150528121353.GP2185@piout.net>
Message-ID: <CAHrpEqShyPKeKYdVZ05_qsbx0cC387a2QPCdbhR5C968n=ED0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 28, 2015 at 7:13 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 27/05/2015 at 20:10:53 +0800, Shawn Guo wrote :
>> On Wed, May 27, 2015 at 12:25:56AM +0800, Frank.Li at freescale.com wrote:
>> > Frank Li (5):
>> >   rtc: arm: imx: snvs: change use syscon to access register
>> >   Document: dt: fsl: snvs: change support syscon
>> >   ARM: dts: imx: update snvs to use syscon access register
>> >   Document: devicetree: input: imx: i.mx snvs power device tree bindings
>> >   ARM: dts: imx6sx: enable snvs power key
>> >
>> > Robin Gong (1):
>> >   input: keyboard: imx: add snvs power key driver
>>
>> The series looks fine to me now.  But I can only apply those two dts
>> patches after the driver and binding parts get landed on mainline.
>> Hopefully, you can get them in during the coming merge window through
>> subsystem trees, so that I can pick up dts part after v4.2-rc1 comes
>> out.
>>
>
> Actually, I was thinking you could take the whole series in your tree
> (at least, I'm speaking for the RTC part).
> Else, I'm wondering who should take the documentation changes.
>

Dmitry Torokhov:

what's your opinion about input part?

best regards
Frank Li

>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
