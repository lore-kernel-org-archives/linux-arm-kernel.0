From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 19 Jan 2015 11:12:45 +0100
Subject: [PATCH RFC] pinctrl: at91
In-Reply-To: <20150114150339.GJ3625@ldesroches-Latitude-E6320>
References: <CACRpkdbkUUzVVMp14szY+vGNd+d+8bL066STh_XMGud-UsFBqA@mail.gmail.com>
 <1418637470-5839-1-git-send-email-ludovic.desroches@atmel.com>
 <54943933.60102@atmel.com>
 <20150106093706.GC26982@ldesroches-Latitude-E6320>
 <CACRpkda9wTPcRy6nRGP08rDpHV=tRyYVuD80TeO2zFGzX+aJcg@mail.gmail.com>
 <20150114150339.GJ3625@ldesroches-Latitude-E6320>
Message-ID: <CACRpkdY6M=U-XA=Sd2DH6jVjCABUTSYq+oUs_DBy14M2tccrMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 4:03 PM, Ludovic Desroches
<ludovic.desroches@atmel.com> wrote:

> From my point of view, it is two distinct topics. One is a very
> important fix because our SAMA5D4 device is not booting without it. The
> other one is a proper way to manage gpio ranges but alone I don't think
> it can solve my issue.

Can you make me a minimal, sane patch that fixes the boot regression?

I hate regressions so these need to be fixed first...

The rest we can discuss I guess.

Or is it not possible to solve the boot regression without the larger
fix?

Yours,
Linus Walleij
