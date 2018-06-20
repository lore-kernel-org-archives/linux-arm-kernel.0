From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Jun 2018 22:22:17 +0200
Subject: [PATCH] ARM: pxa: mioa701 convert to the new AC97 bus
In-Reply-To: <20180527192338.21606-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sun, 27 May 2018 21:23:38 +0200")
References: <20180527192338.21606-1-robert.jarzmik@free.fr>
Message-ID: <878t79p5s6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This migration implies :
>  - wm9713 device is removed, it will be auto-probed
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/mioa701.c | 2 --
>  1 file changed, 2 deletions(-)
Queued to pxa/for-next.

--
Robert
