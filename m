From: pombredanne@nexb.com (Philippe Ombredanne)
Date: Mon, 11 Dec 2017 12:28:04 +0100
Subject: [PATCH v3 3/4] rtc: add mxc driver for i.MX53 SRTC
In-Reply-To: <20171211105657.20251-4-linux-kernel-dev@beckhoff.com>
References: <20171211105657.20251-1-linux-kernel-dev@beckhoff.com>
 <20171211105657.20251-4-linux-kernel-dev@beckhoff.com>
Message-ID: <CAOFm3uHkZoRqdbv1O0kGD6Jomexj3a3pAhUrMYJyphSu0gLdhQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 11, 2017 at 11:56 AM,  <linux-kernel-dev@beckhoff.com> wrote:
> From: Patrick Bruenn <p.bruenn@beckhoff.com>
>
> Neither rtc-imxdi, rtc-mxc nor rtc-snvs are compatible with i.MX53.
>
> This is driver enables support for the low power domain SRTC features:
> - 32-bit MSB of non-rollover time counter
> - 32-bit alarm register
>
> Select the new config option RTC_DRV_MXC_V2 to build this driver
>
> Based on:
> http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/drivers/rtc/rtc-mxc_v2.c?h=imx_2.6.35_11.09.01
>
> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
[...]
> v2:
[...]
> - add SPDX-License-Identifier and cleanup copyright notice

Thank you for using the SPDX ids in this patch series.

Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

-- 
Cordially
Philippe Ombredanne
