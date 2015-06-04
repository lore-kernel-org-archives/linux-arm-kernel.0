From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Thu, 4 Jun 2015 09:22:07 +0000
Subject: [patch] gpio: Added GPIO support to ZynqMP SoC
In-Reply-To: <CACRpkdZpvr4NfH43FvoHdfKaqqDGMHJU5=UHEzOpLV9xC4vaTw@mail.gmail.com>
References: <1433160019-11157-1-git-send-email-anuragku@xilinx.com>
 <CACRpkdZpvr4NfH43FvoHdfKaqqDGMHJU5=UHEzOpLV9xC4vaTw@mail.gmail.com>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA98011EBF75@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> -----Original Message-----
> From: Linus Walleij [mailto:linus.walleij at linaro.org]
> Sent: Thursday, June 04, 2015 1:38 PM
> To: Anurag Kumar Vulisha
> Cc: Alexandre Courbot; Michal Simek; Soren Brinkmann; linux-
> gpio at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Punnaiah Choudary Kalluri; Srikanth Vemula;
> Anirudha Sarangi; Anurag Kumar Vulisha
> Subject: Re: [patch] gpio: Added GPIO support to ZynqMP SoC
>
> On Mon, Jun 1, 2015 at 2:00 PM, Anurag Kumar Vulisha
> <anurag.kumar.vulisha@xilinx.com> wrote:
>
> > Added support to ZynqMP SoC on the existing zynq gpio driver.
> >
> > Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
>
> > +static const struct of_device_id zynq_gpio_of_match[] = {
> > +       { .compatible = "xlnx,zynq-gpio-1.0", .data = (void *)&zynq_gpio_def
> },
> > +       { .compatible = "xlnx,zynqmp-gpio-1.0",
> > +                                       .data = (void
> > +*)&zynqmp_gpio_def },
>
> Is there a separate patch adding this to the device tree bindings in
> Documentation/devicetree/bindings/gpio/gpio-zynq.txt?
>
> Else please include it in this patch.

I will include the device-tree bindings and send the patch as v2.

Thanks,
Anurag Kumar V


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
