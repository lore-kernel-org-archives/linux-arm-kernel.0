From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 18 Aug 2014 23:43:49 +0200
Subject: [RESEND PATCH 1/2] ARM: dts: Improve Peach Pit and Pi power scheme
In-Reply-To: <53F245A4.5010106@samsung.com>
References: <1407757091-18730-1-git-send-email-javier.martinez@collabora.co.uk>
 <CAD=FV=UbckfwGucuPjEtHixVgF5K2fD5N3EPS2BH96DRDACuqw@mail.gmail.com>
 <53F245A4.5010106@samsung.com>
Message-ID: <53F27395.5070601@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kukjin,

On 08/18/2014 08:27 PM, Kukjin Kim wrote:
> On 08/11/14 10:46, Doug Anderson wrote:
>>
> OK, I've applied this but 2nd in this series...
>

Thanks for picking this and yes PATCH 2/2 from this series was dropped.

>> Acked-by: Doug Anderson<dianders@chromium.org>
>>
> Thanks,
> Kukjin
> 

I've posted PATCH "mmc: core: Use regulator_get_voltage() if OCR mask is
empty." [0] instead to solve the issue that patch 2/2 tried to address.

Best regards,
Javier

[0]: https://lkml.org/lkml/2014/8/14/200
