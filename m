From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 27 Apr 2012 11:11:58 +0800
Subject: [PATCH 1/2] ARM: PXA2xx: MFP: fix bug with MFP_LPM_KEEP_OUTPUT
In-Reply-To: <1334234609-780-1-git-send-email-grinberg@compulab.co.il>
References: <1334234609-780-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <CAN1soZz786eK0_-hLZLJamj_3aiJe9PAwS9i+W5_Q0zuRf1Vaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2012 at 8:43 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
> Pins that have MFP_LPM_KEEP_OUTPUT set and are configured for output
> must retain the output state in low power mode.
> Currently, the pin direction configuration is overrided with values
> in gpdr_lpm[] array and do not obey the MFP_LPM_KEEP_OUTPUT setting.
>
> Fix the above bug and add some documentation to clarify the
> MFP_LPM_KEEP_OUTPUT setting purpose.
>
> Reported-by: Paul Parsons <lost.distance@yahoo.com>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Tested-by: Paul Parsons <lost.distance@yahoo.com>
> ---
> ?arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h | ? ?7 +++++++
> ?arch/arm/mach-pxa/mfp-pxa2xx.c ? ? ? ? ? ? ?| ? 12 ++++++++++--
> ?2 files changed, 17 insertions(+), 2 deletions(-)
>
Applied

Regards
Haojian
