From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 3 May 2012 09:55:08 +0800
Subject: [PATCH RESEND 2/3 v6] ARM: pxa: hx4700: Add PCMCIA/CF support
In-Reply-To: <E1SPboE-0004O5-4i@merlin.infradead.org>
References: <E1SPboE-0004O5-4i@merlin.infradead.org>
Message-ID: <CAN1soZyKMkhJBB_AxTt6=zuWK5_VuPGE=vRgfO4EM8-djASERA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 11:49 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> This patch is part of a set which adds PCMCIA/CF support for the hx4700.
> This patch modifies asic3_gpio_config[] as follows:
> 1. Remove ASIC3_GPIOC4_CF_nCD, whose purpose is unknown.
> 2. Add ASIC3_GPIOD4_CF_nCD, the actual CF card detect GPIO.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
>
Applied

Regards
Haojian
