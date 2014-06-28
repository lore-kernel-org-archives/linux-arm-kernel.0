From: gnurou@gmail.com (Alexandre Courbot)
Date: Sat, 28 Jun 2014 12:14:57 +0900
Subject: [PATCH V5 0/3] gpio: Add APM X-Gene SoC platform GPIO driver
In-Reply-To: <1403823587-23404-1-git-send-email-fkan@apm.com>
References: <1403823587-23404-1-git-send-email-fkan@apm.com>
Message-ID: <CAAVeFuLZNr-bkXM-1S15tpz0da7pnppjNbJ6iOZ-6RzEDBZ_Jg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 7:59 AM, Feng Kan <fkan@apm.com> wrote:
> This patch add the GPIO controller in the APM X-Gene platform. The GPIO
> controller pins are muxed with the generic flash controller pins on the
> system.
>
> V5 Change:
>         1. Remove gpio->dev
>         2. Remove not needed headers.
>         3. Change to use latest driver.h for gpio.
>         4. Set chip base to -1
>         5. Put back label as it is needed sys interface.

Let's see what Linus has to say, but to me this iteration looks good!

The series,

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
