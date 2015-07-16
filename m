From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 16 Jul 2015 21:12:51 +0200
Subject: [PATCH 8/8] pcmcia: soc_common: remove skt_dev_info's clk pointer
In-Reply-To: <E1ZFR2p-0007Ms-4w@rmk-PC.arm.linux.org.uk> (Russell King's
 message of "Wed, 15 Jul 2015 19:04:35 +0100")
References: <20150715180342.GB7557@n2100.arm.linux.org.uk>
 <E1ZFR2p-0007Ms-4w@rmk-PC.arm.linux.org.uk>
Message-ID: <871tg7kjbg.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King <rmk+kernel@arm.linux.org.uk> writes:

> We no longer need to store the clk pointer in struct skt_dev_info as we
> no longer need to remember the clk pointer for the cleanup paths.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
