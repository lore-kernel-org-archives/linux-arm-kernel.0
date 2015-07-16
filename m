From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 Jul 2015 21:12:23 +0200
Subject: [PATCH 3/8] pcmcia: pxa2xx: update socket driver to use
 devm_clk_get() API
In-Reply-To: <E1ZFR2P-0007MM-Gp@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Wed, 15 Jul 2015 19:04:09 +0100")
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
 <E1ZFR2P-0007MM-Gp@rmk-PC.arm.linux.org.uk>
Message-ID: <87a8uvkjc8.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Update the pxa2xx socket driver to use the devm_clk_get() API so that
> the cleanup paths are simplified.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
