From: prabhakar.csengg@gmail.com (Lad, Prabhakar)
Date: Thu, 19 Nov 2015 13:26:06 +0000
Subject: [PATCH] [media] davinci: add i2c Kconfig dependencies
In-Reply-To: <4284996.N31E5Y01de@wuerfel>
References: <4284996.N31E5Y01de@wuerfel>
Message-ID: <CA+V-a8tuUS2x5vdFUZVWvd2C7LiiCQhvpH-zmTsii3uMcJCLmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2015 at 12:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> All the davinci media drivers are using the i2c framework, and
> fail to build if that is ever disabled, e.g.:
>
> media/platform/davinci/vpif_display.c: In function 'vpif_probe':
> media/platform/davinci/vpif_display.c:1298:14: error: implicit declaration of function 'i2c_get_adapter' [-Werror=implicit-function-declaration]
>
> This adds explicit Kconfig dependencies so we don't see the
> driver options if I2C is turned off.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>

Cheers,
--Prabhakar Lad
