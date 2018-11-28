From: otavio.salvador@ossystems.com.br (Otavio Salvador)
Date: Wed, 28 Nov 2018 18:06:37 -0200
Subject: [PATCH] ARM: dts: imx7d-pico: Describe the Wifi clock
In-Reply-To: <1543432806-11949-1-git-send-email-festevam@gmail.com>
References: <1543432806-11949-1-git-send-email-festevam@gmail.com>
Message-ID: <CAP9ODKoODBGXJfP48MH0DA0DiG=MZv6LrgU1Bhb+dqmBZma5+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 5:20 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> The Wifi chip should be clocked by a 32kHz clock coming from i.MX7D
> CLKO2 output pin, so describe the pinmux and clock hierarchy in the
> device tree to allow the Wifi chip to be properly clocked.
>
> Managed to successfully test Wifi with such change. Used the standard
> nvram.txt file provided by Technexion, which selects an external 32kHz
> clock for the Wifi chip by default.
>
> Suggested-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Tested-by: Otavio Salvador <otavio@ossystems.com.br>

-- 
Otavio Salvador                             O.S. Systems
http://www.ossystems.com.br        http://code.ossystems.com.br
Mobile: +55 (53) 9 9981-7854          Mobile: +1 (347) 903-9750
