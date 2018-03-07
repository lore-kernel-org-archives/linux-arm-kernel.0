From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Mar 2018 16:35:52 +0100
Subject: [PATCH resend] ARM: dts: atlas7: Use generic uart-has-rtscts DT
 property
In-Reply-To: <1519999365-15201-1-git-send-email-geert+renesas@glider.be>
References: <1519999365-15201-1-git-send-email-geert+renesas@glider.be>
Message-ID: <CAK8P3a1EjwDSZooPvY-9jv1gsRBzCFsQifg-erEpiK52O9jC+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 3:02 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> As of commit 7f60830ab1511d94 ("serial: sirf: Use generic
> uart-has-rtscts DT property property"), the SiRF UART driver recognizes
> the generic "uart-has-rtscts" DT property, deprecating the
> vendor-specific "sirf,uart-has-rtscts" DT property. Hence replace the
> latter by the former in all DTS files.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Pulled into next/dt, thanks!
