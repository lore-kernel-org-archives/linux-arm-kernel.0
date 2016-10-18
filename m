From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 18 Oct 2016 08:49:21 +0200
Subject: [PATCH] ARM: pxa: fix pxa25x interrupt init
In-Reply-To: <1474874511-26617-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Mon, 26 Sep 2016 09:21:51 +0200")
References: <1474874511-26617-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <878ttm5ez2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> In the device-tree case, the root interrupt controller cannot be
> accessed through the 6th coprocessor, contrary to pxa27x and pxa3xx
> architectures.
>
> Fix it to behave as in non-devicetree builds.
>
> Fixes: 32f17997c130 ("ARM: pxa: remove irq init from dt machines")
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to pxa/fixes.

-- 
Robert
