From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 3 May 2012 09:50:50 +0800
Subject: [PATCH RESEND] ARM: pxa: hx4700: Enable ASIC3 GPIO as a wakeup
 source
In-Reply-To: <E1SPbo7-0004My-Nb@merlin.infradead.org>
References: <E1SPbo7-0004My-Nb@merlin.infradead.org>
Message-ID: <CAN1soZxTBLPYwCONpbf42bbPSC0C5Tmm-QVh0_gRM+7v1WkGNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 11:49 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> This patch enables the ASIC3 GPIO (12) as a wakeup source:
> 1. Set the WAKEUP_ON_EDGE_RISE MFP config bits for GPIO12 in
> hx4700_pin_config[].
> 2. Call gpio_set_wake() for GPIO12.
>
> With GPIO12 thus enabled, the mfd/asic3 driver can enable its own GPIOs
> as wakeup sources by implementing a irq_set_wake() handler.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
> ?arch/arm/mach-pxa/hx4700.c | ? ?3 ++-
> ?1 files changed, 2 insertions(+), 1 deletions(-)
>
Applied

Regards
Haojian
