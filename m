From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 13 Nov 2014 09:45:09 +0100
Subject: [PATCH 1/1] ARM: exynos_defconfig: Enable max77802 rtc and clock
 drivers
In-Reply-To: <04e101cff29f$4021ea00$c065be00$@kernel.org>
References: <1414401440-10972-1-git-send-email-javier.martinez@collabora.co.uk>
 <04e101cff29f$4021ea00$c065be00$@kernel.org>
Message-ID: <CABxcv=kaOa1+6a1n_+GjoH=PgG=LzAnXLU7U_E5NvYYP-0WedA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On Tue, Oct 28, 2014 at 12:06 PM, Kukjin Kim <kgene@kernel.org> wrote:
> Javier Martinez Canillas wrote:
>> Commit 6e80e3d87549 ("ARM: exynos_defconfig: Enable MAX77802")
>> enabled support for the max77802 regulators but the PMIC also
>> has a Real-Time-Clock (RTC) and 2-channel 32kHz clock outputs.
>>
>
> I'll apply this, thanks.
>
> - Kukjin
>

You say that you will apply this patch but I can't find it in any of
your branches.

Best regards,
Javier
