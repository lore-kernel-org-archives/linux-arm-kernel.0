From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 09 Dec 2015 21:38:59 +0100
Subject: [PATCH] ARM: pxa: use PWM lookup table for all machines
In-Reply-To: <3221771.lHXPua29rx@wuerfel> (Arnd Bergmann's message of "Wed, 09
 Dec 2015 17:35:05 +0100")
References: <3221771.lHXPua29rx@wuerfel>
Message-ID: <877fknl5lo.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The recent change to use a pwm lookup table for the ezx machines
> was incomplete and only changed the a780 model, but not the
> other ones in the same file.
>
> This adds the missing calls to pwm_add_table().
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: c3322022897c ("ARM: pxa: ezx: Use PWM lookup table")
> Acked-by: Thierry Reding <thierry.reding@gmail.com>
> ---
> If nobody has any objections, I'll queue this up for 4.4. No backport
> is needed as it only broke in this release.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
