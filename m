From: rogershimizu@gmail.com (Roger Shimizu)
Date: Wed, 18 Jan 2017 21:08:13 +0900
Subject: [PATCH v4 1/2] power: reset: add linkstation-reset driver
In-Reply-To: <20170107150451.17912-2-rogershimizu@gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
Message-ID: <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian,

On Sun, Jan 8, 2017 at 12:04 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> Buffalo Linkstation / KuroBox and their variants need magic command
> sending to UART1 to power-off.
>
> Power driver linkstation-reset implements the magic command and I/O
> routine, which come from files listed below:
>   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>   - arch/arm/mach-orion5x/terastation_pro2-setup.c

I think there's not much concern regarding to this series.
Could you kindly help to apply this patch?
Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
