From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 30 Dec 2011 08:36:33 +0800
Subject: [PATCH 2/4] ARM: pxa168: Add SDHCI support
In-Reply-To: <1325166236-18650-1-git-send-email-tanmay.upadhyay@einfochips.com>
References: <CAN1soZwwPe1Xdh=EO-wdynihaBQ8DvWV=imjokJvDZVC+qqdSg@mail.gmail.com>
 <1325166236-18650-1-git-send-email-tanmay.upadhyay@einfochips.com>
Message-ID: <CAN1soZwG37noxK8CUe7zMtaNJPTWSok5ROUXj_YvZ+dLEVkomA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2011 at 9:43 PM, Tanmay Upadhyay
<tanmay.upadhyay@einfochips.com> wrote:
> v2 - clock register for SDHCI are not common across all MMP SoCs.
> ? ? So, move PXA168 implementation to pxa168.c
>
> v3 - sdhci-pxav1 driver code is merged with sdhci-pxav2. So, change
> ? ? the device name accordingly
> ? - start sdhci device numbering from 1 as other PXA168 devices
> ? ? does that
>
> v4 - Use different names for SD clock registers for PXA168 instead
> ? ? of redefining them in pxa168.c. Suggested by Haojian Zhuang
>
> v5 - Have two different clock enable functions for clock block 1 & 2
> ? ? & don't change indentation in regs-apmu.h as suggested by Haojian
> ? ? Zhuang
> ? - Use device name while adding clock as suggested by Russell King
>
> Signed-off-by: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
> Reviewed-by: Philip Rakity <prakity@marvell.com>
> ---

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
