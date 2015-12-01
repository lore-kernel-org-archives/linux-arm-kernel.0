From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 01 Dec 2015 08:22:34 +0100
Subject: [PATCH] ARM: pxa: make more mach/*.h files local
In-Reply-To: <1905725.SU2iekYqHg@wuerfel> (Arnd Bergmann's message of "Mon, 30
 Nov 2015 15:53:01 +0100")
References: <1905725.SU2iekYqHg@wuerfel>
Message-ID: <87a8pu7hvp.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Lots of header files are never included outside of a mach-pxa
> directory and do not need to be made visible in include/mach,
> so let's just move them all down one level.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I've been carrying patches like this one in my multiplatform series
> for a while, the PXA one is the largest.
>
> I'd like to merge that for 4.5, any objections?
No, I like this very much.
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

> Do you want to take it into a PXA branch to avoid conflicts, or should
> I put it into arm-soc directly?
I don't have any patch so far queued for v4.5, so please take it, I think I'll
skip v4.5 pull.

Cheers.

--
Robert
