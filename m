From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 20 Feb 2016 22:03:41 +0100
Subject: [PATCH] ARM: pxa: pxa3xx device-tree support cleanup
In-Reply-To: <1454795315-11294-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sat, 6 Feb 2016 22:48:35 +0100")
References: <1454795315-11294-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87lh6fxff6.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Clocks, timer and several other drivers have well defined and working
> device-tree bindings. Clean-up the code to leave only the strict
> minimum. The final goal will be to remove the lookup array.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Queued to pxa/for-next, thanks.

--
Robert
