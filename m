From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Nov 2015 09:54:10 +0100
Subject: [PATCH 0/4] gpio: lpc32xx: add new LPC32xx GPIO controller driver
In-Reply-To: <1447982995-30231-1-git-send-email-vz@mleia.com>
References: <1447982995-30231-1-git-send-email-vz@mleia.com>
Message-ID: <CACRpkdYN+_2qrP3tDDj2SxDAEJr05FnPLKyFPEF9BGdVyQdTuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 20, 2015 at 2:29 AM, Vladimir Zapolskiy <vz@mleia.com> wrote:

> Unfortunately the old driver has too many hacks inherited from the
> ancient legacy NXP BSP and I find it can not be maintained, the new
> driver has compatible interface to device tree clients, so moving
> to the new driver should not impact any GPIO consumers.

Has it been tested on the old hardware too?

Yours,
Linus Walleij
