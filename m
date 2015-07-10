From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Fri, 10 Jul 2015 07:29:39 +0000
Subject: [PATCH] i2c: removed work arounds in i2c driver for Zynq
 Ultrascale+ MPSoC
In-Reply-To: <20150709200913.GL4744@katana>
References: <1434644382-11905-1-git-send-email-anuragku@xilinx.com>
 <20150709200913.GL4744@katana>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA98011EFAFC@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
        Thanks for reviewing the code. I will make the changes as said and send the patch as v2.
Thanks,
Anurag Kumar V

> -----Original Message-----
> From: Wolfram Sang [mailto:wsa at the-dreams.de]
> Sent: Friday, July 10, 2015 1:39 AM
> To: Anurag Kumar Vulisha
> Cc: robh+dt at kernel.org; pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek; Soren
> Brinkmann; linux-i2c at vger.kernel.org; devicetree at vger.kernel.org; linux-
> kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Punnaiah
> Choudary Kalluri; Harini Katakam; Anirudha Sarangi; Srikanth Vemula; Anurag
> Kumar Vulisha
> Subject: Re: [PATCH] i2c: removed work arounds in i2c driver for Zynq
> Ultrascale+ MPSoC
>
> Hi,
>
> thanks for the submission!
>
> > +#define CDNS_I2C_BROKEN_HOLD_BIT   0x00000001
>
> BIT(0) maybe?
>
> > +static const struct cdns_platform_data r1p10_i2c_def = {
> > +                           .quirks = CDNS_I2C_BROKEN_HOLD_BIT, };
>
> Closing '}' should be on seperate line.
>
> And what Mark said.
>
> Other than that, looks okay I'd say.



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
