From: cjb@laptop.org (Chris Ball)
Date: Wed, 30 May 2012 23:23:37 -0400
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <CAN1soZz2=NcadK1kD6d9t92G6Xdfn=TPGP5_ngwX_fGj+QhOVA@mail.gmail.com>
 (Haojian Zhuang's message of "Thu, 31 May 2012 11:07:52 +0800")
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
 <87ehq1tq5w.fsf@laptop.org>
 <CAN1soZz2=NcadK1kD6d9t92G6Xdfn=TPGP5_ngwX_fGj+QhOVA@mail.gmail.com>
Message-ID: <87vcjdm3t2.fsf@laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 30 2012, Haojian Zhuang wrote:
>> Did you test non-DT boot with these changes?
>>
> I tested non-DT boot on my brownstone board on TTC dkb board.

Thanks.  Do you know how/where cascade_irq gets set on that board?

> It seems that you meet issue in icu_mux_irq_demux(). Could you give me
> the detail which interrupt is running while you meet the error?

It was IRQ 17 (TWSI).

> By the way, do you have the boot log?

I'll send it tomorrow when I get back to work.

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
