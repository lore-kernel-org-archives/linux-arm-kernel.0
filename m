From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 Jul 2015 21:12:40 +0200
Subject: [PATCH 4/8] pcmcia: pxa2xx: convert memory allocation to devm_*
 API
In-Reply-To: <E1ZFR2U-0007MS-Lr@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Wed, 15 Jul 2015 19:04:14 +0100")
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
 <E1ZFR2U-0007MS-Lr@rmk-PC.arm.linux.org.uk>
Message-ID: <87615jkjbr.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> Convert the pxa2xx socket driver memory allocation to use devm_kzalloc()
> to simplify the cleanup path.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
