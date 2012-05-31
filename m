From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 31 May 2012 11:07:52 +0800
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <87ehq1tq5w.fsf@laptop.org>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <1335515957-1798-4-git-send-email-haojian.zhuang@gmail.com>
 <87ehq1tq5w.fsf@laptop.org>
Message-ID: <CAN1soZz2=NcadK1kD6d9t92G6Xdfn=TPGP5_ngwX_fGj+QhOVA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 31, 2012 at 3:38 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Haojian,
>

>
> Did you test non-DT boot with these changes?
>
I tested non-DT boot on my brownstone board on TTC dkb board.

It seems that you meet issue in icu_mux_irq_demux(). Could you give me
the detail which interrupt is running while you meet the error?

By the way, do you have the boot log?

Regards
Haojian
