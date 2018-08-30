From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 30 Aug 2018 21:52:23 +0200
Subject: [PATCH] ARM: dts: pxa: change serial node names
In-Reply-To: <20180715202153.7233-1-robert.jarzmik@free.fr> (Robert Jarzmik's
 message of "Sun, 15 Jul 2018 22:21:53 +0200")
References: <20180715202153.7233-1-robert.jarzmik@free.fr>
Message-ID: <87k1o77hu0.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Change from xxuart to serial to normalize the devicetree pxa serial
> support.
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
>  arch/arm/boot/dts/pxa2xx.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
Queued to pxa/dt.

--
Robert
