From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 06 Jan 2014 09:19:22 +0100
Subject: [PATCH] ARM: pxa: Add dummy backlight power supply on Mitac Mio
 A701
In-Reply-To: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
 (Thierry Reding's message of "Fri, 20 Dec 2013 10:46:52 +0100")
References: <1387532812-11742-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <87zjn9v7xx.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thierry Reding <thierry.reding@gmail.com> writes:

> Recent changes to the pwm-backlight driver have made the power supply
> mandatory. There is code in the regulator core to deal with situations
> where no regulator is specified and provide a dummy, but that works on
> DT-based boards only.
>
> The situation can be remedied by adding a dummy regulator during board
> initialization.

Haojian, ping ?
We're at -rc7 and I've seen no pull of this fix. As the display is broken
without it, I'd really like to have it fixed for v3.13.

Cheers.

--
Robert
