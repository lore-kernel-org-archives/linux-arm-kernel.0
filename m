From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 26 Jan 2014 09:04:12 +0100
Subject: [PATCH v4 07/18] watchdog: orion: Handle IRQ
In-Reply-To: <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1390431915-5115-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1390431915-5115-8-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140126090412.37f4932f@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Ezequiel Garcia,

On Wed, 22 Jan 2014 20:05:04 -0300, Ezequiel Garcia wrote:
> DT-enabled where an irqchip driver for the brigde interrupt controller is
> available can handle the watchdog IRQ properly. Therefore, we request
> the interruption and add a dummy handler that merely calls panic().

I don't quiite understand the first sentence of this commit log, and
the commit title looks wrong. Maybe a bad copy/paste or something?

> 
> This is done in order to have an initial 'ack' of the interruption,

interruption -> interrupt

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
