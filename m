From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Sat, 23 Aug 2014 01:31:07 +0200
Subject: [PATCH 2/3] ARM: dts: Add DT changes for display on peach_pit
In-Reply-To: <1406317464-7525-3-git-send-email-ajaykumar.rs@samsung.com>
References: <1406317464-7525-1-git-send-email-ajaykumar.rs@samsung.com>
 <1406317464-7525-3-git-send-email-ajaykumar.rs@samsung.com>
Message-ID: <CABxcv==PJGDQ85r13OOoWdDONTHu8NYBciNeLLUHQjanoMJYyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ajay,

On Fri, Jul 25, 2014 at 9:44 PM, Ajay Kumar <ajaykumar.rs@samsung.com> wrote:
> Add DT nodes for ps8622 bridge chip and panel-simple panel.
> Add backlight power supply for pwm-backlight.
> Also add bridge phandle needed by dp to enable display on peach_pit.
>
> Note that, peach_pit doesn't support "chunghwa,claa101wb01" panel,
> but still we choose to reuse the binding since "chunghwa,claa101wb01"
> has similar LCD timings.
>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---

Tested-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Best regards,
Javier
