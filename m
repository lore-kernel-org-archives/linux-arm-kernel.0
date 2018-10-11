From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Oct 2018 16:11:42 +0200
Subject: [PATCH] MAINTAINERS: Assign myself as a maintainer of ARM/LPC18XX
 architecture
In-Reply-To: <20181011123116.24885-1-vz@mleia.com>
References: <20181011123116.24885-1-vz@mleia.com>
Message-ID: <CAK8P3a3pbpEX1BjKvn179pTYtYEtiQnd=SmD5NYkAtpdZAonkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/18, Vladimir Zapolskiy <vz@mleia.com> wrote:
> To all appearance Joachim Eastwood abandoned the maintenance of NXP
> LPC18xx/LPC43xx archtecture about two years ago, and for me it would be
> possible to continue the support, fortunately the quality of platform
> drivers written by Joachim is exceptionally high.
>
> The change is based on https://lkml.org/lkml/2018/9/24/1398 discussion.
>
> At the same time two redundant explicit driver file paths are dropped
> from the list, clk-lpc18xx* drivers are covered by "lpc18xx" search
> pattern and timer-lpc32xx driver is covered by "lpc32xx" pattern and it
> goes into ARM/LPC32XX entry, which is also under my wing, in other words
> LPC18xx/LPC43xx clocksource and CCF drivers will remain maintained.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> ---

I could not automatically apply this with 'git am', not sure what the
problem was, but I managed to apply it by patching the file manually.

Thanks for taking over the platform!

      Arnd
