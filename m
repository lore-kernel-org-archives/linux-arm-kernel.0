From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 20 Jun 2018 22:23:35 +0200
Subject: [PATCH] ARM: pxa: add the missing AC97 clocks
In-Reply-To: <20180603201539.15704-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sun, 3 Jun 2018 22:15:39 +0200")
References: <20180603201539.15704-1-robert.jarzmik@free.fr>
Message-ID: <874lhxp5q0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> The AC97 bit clock is added as the pxa internally generated 13MHz
> clock. This is a consequence of the new ac97 framework.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/mach-pxa/devices.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
Queued to pxa/for-next.

--
Robert
