From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 5 May 2010 15:03:40 +0800
Subject: spitz 2.6.34-rc4: fix On/off key name to fix warning during boot
In-Reply-To: <20100416131245.GA1306@ucw.cz>
References: <20100416131245.GA1306@ucw.cz>
Message-ID: <k2nf17812d71005050003x74225885h7dc29e4361890e5d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 16, 2010 at 9:12 PM, Pavel Machek <pavel@ucw.cz> wrote:
> On/Off contains slash in the name, which causes warning during boot.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>

Applied.

> --- ./arch/arm/mach-pxa/spitz.c 2010-03-21 22:09:12.000000000 +0100
> +++ ./arch/arm/mach-pxa/spitz.c 2010-04-16 03:45:07.000000000 +0200
> @@ -363,7 +363,7 @@
> ? ? ? ? ? ? ? ?.type ? = EV_PWR,
> ? ? ? ? ? ? ? ?.code ? = KEY_SUSPEND,
> ? ? ? ? ? ? ? ?.gpio ? = SPITZ_GPIO_ON_KEY,
> - ? ? ? ? ? ? ? .desc ? = "On/Off",
> + ? ? ? ? ? ? ? .desc ? = "On Off",
> ? ? ? ? ? ? ? ?.wakeup = 1,
> ? ? ? ?},
> ? ? ? ?/* Two buttons detecting the lid state */
>
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
>
