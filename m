From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 3 May 2012 09:48:47 +0800
Subject: [PATCH RESEND] ARM: pxa: hx4700: Initialize DS1WM clock_rate
In-Reply-To: <E1SPbo0-0004MU-OV@merlin.infradead.org>
References: <E1SPbo0-0004MU-OV@merlin.infradead.org>
Message-ID: <CAN1soZyPXOe7bWkyCdJc608Ag6DEm0NTZYtmt1UApa2TfugHMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 11:49 PM, Paul Parsons <lost.distance@yahoo.com> wrote:
> The asic3 driver now sets the DS1WM clock_rate from the newly added
> asic3_platform_data clock_rate field.
>
> This patch initializes the asic3_platform_data clock_rate field on the
> hx4700 platform.
>
> Signed-off-by: Paul Parsons <lost.distance@yahoo.com>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> ---
Applied

Regards
Haojian
