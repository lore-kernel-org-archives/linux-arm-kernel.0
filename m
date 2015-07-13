From: lznuaa@gmail.com (Zhi Li)
Date: Mon, 13 Jul 2015 10:19:23 -0500
Subject: [PATCH v3 1/7] ARM: imx: add i.mx6ul msl support
In-Reply-To: <20150713151455.GC26642@tiger>
References: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
 <1436462204-32654-2-git-send-email-Frank.Li@freescale.com>
 <20150709183917.GK12326@tarshish>
 <CAHrpEqTA4LeTdMFCb1jzbzDrUT2oE61uM7bmhKFgM7TKJmaDjA@mail.gmail.com>
 <20150713151455.GC26642@tiger>
Message-ID: <CAHrpEqQywcFGk9YjStxuwjDeZjigeymqYiSq4RAaNcdePS9ptg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:14 AM, Shawn Guo <shawnguo@kernel.org> wrote:
> On Thu, Jul 09, 2015 at 01:41:29PM -0500, Zhi Li wrote:
>> On Thu, Jul 9, 2015 at 1:39 PM, Baruch Siach <baruch@tkos.co.il> wrote:
>> > Hi Frank,
>> >
>> > On Fri, Jul 10, 2015 at 01:16:38AM +0800, Frank.Li at freescale.com wrote:
>> >> +DT_MACHINE_START(IMX7D, "Freescale i.MX6 Ultralite (Device Tree)")
>> >
>> > IMX7D?
>>
>> Good capture. I will update it.
>> Strange. why system can boot?
>
> As long as the compatible string in imx6ul_dt_compat matches device
> tree, system can boot.

Thank you very much.
I have fixed it at V3.

best regards
Frank Li

>
> Shawn
>
>>
>> >
>> >> +     .init_irq       = imx6ul_init_irq,
>> >> +     .init_machine   = imx6ul_init_machine,
>> >> +     .dt_compat      = imx6ul_dt_compat,
>> >> +MACHINE_END
>> >
>> > baruch
>> >
>> > --
>> >      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
>> > =}------------------------------------------------ooO--U--Ooo------------{=
>> >    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
