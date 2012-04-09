From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 9 Apr 2012 10:04:02 +0800
Subject: [PATCH v2 5/7] ARM: mmp: append OF support on pxa168
In-Reply-To: <87hawtzn8z.fsf@laptop.org>
References: <1330950111-30797-1-git-send-email-haojian.zhuang@marvell.com>
 <1330950111-30797-6-git-send-email-haojian.zhuang@marvell.com>
 <87y5q5znx8.fsf@laptop.org>
 <CAN1soZyXH_fpwOdDESB600MAm0FL_aanhnVKaLke0O+6B_v9dg@mail.gmail.com>
 <87hawtzn8z.fsf@laptop.org>
Message-ID: <CAN1soZy55KhL-pkK4QHsaumk+0d9P6Qj_+8f8OvakHF5qZWe7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 9, 2012 at 9:51 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Sun, Apr 08 2012, Haojian Zhuang wrote:
>> There's a typo error in comments. MMP_DT is only for PXA168 & PXA910.
>> We need to append MMP2_DT for ARMv7 in arch-mmp directory. Since we
>> are not intended to build ARMv5 and ARMv7 together.
>
> Okay. ?In that case, you should make sure that MMP_DT cannot be selected
> when CPU_MMP2 is selected, by encoding that dependency in the Kconfig.
>
Sure. I'll protect it in Kconfig.

Thanks
Haojian
