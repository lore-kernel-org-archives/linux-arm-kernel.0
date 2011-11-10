From: eric.y.miao@gmail.com (Eric Miao)
Date: Thu, 10 Nov 2011 15:34:25 +0800
Subject: CONFIG_USB_GADGET_PXA27X
In-Reply-To: <20111110060231.GB18919@legolas.emea.dhcp.ti.com>
References: <1320870640.27598.33.camel@x61.thuisdomein>
 <20111109220144.GA17605@legolas.emea.dhcp.ti.com>
 <CAN1soZzFMg+d5H2nCb-w_FAjVCQQHF0Fu-prQAbuEQtqwbtDqg@mail.gmail.com>
 <20111110060231.GB18919@legolas.emea.dhcp.ti.com>
Message-ID: <CAMPhdO9wts8MZ0bF3grLyUOTszbfQBqthTgT7MniAc8AL3DuMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 10, 2011 at 2:02 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Thu, Nov 10, 2011 at 07:15:18AM +0800, Haojian Zhuang wrote:
>> From: Haojian Zhuang <haojian.zhuang@hexinfolabs.org>
>> To: haojian.zhuang at gmail.com
>> Cc: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Subject: [PATCH] ARM: pxa: fix inconsistent CONFIG_USB_PXA27X
>> Date: Thu, 10 Nov 2011 07:13:07 +0800
>> Message-Id: <1320880387-13440-1-git-send-email-haojian.zhuang@hexinfolabs.org>
>> X-Mailer: git-send-email 1.7.4.1
>>
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>>
>> Since CONFIG_USB_GADGET_PXA27X and other macros are renamed to
>> CONFIG_USB_PXA27X. Update them in arch/arm/mach-pxa and arch/arm/configs
>> to keep consistent.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>
> FWIW:
>
> Acked-by: Felipe Balbi <balbi@ti.com>

Applied, thanks Felipe. And I guess this is also applicable to v3.1,
stable@ Cc'ed.

>
> --
> balbi
>
