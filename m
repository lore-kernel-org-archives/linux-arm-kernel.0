From: olof@lixom.net (Olof Johansson)
Date: Tue, 20 Nov 2012 23:36:46 -0800
Subject: [PATCH v3 0/9] GIC and VIC clean-ups
In-Reply-To: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
References: <1353466713-18967-1-git-send-email-robherring2@gmail.com>
Message-ID: <20121121073646.GL7615@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 20, 2012 at 08:58:24PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series is in preparation to move gic and vic to drivers/irqchip.
> I dropped the actual move to drivers/irqchip as the infrastructure is
> still being flushed out and I'd like to get the clean-ups at least into
> 3.8.
> 
> This series is available here:
> git://sources.calxeda.com/kernel/linux.git irqchip-cleanup

Series as a whole:
Acked-by: Olof Johansson <olof@lixom.net>

(I did notice you lack your signed-off-by on the two patches you didn't
write, btw).

-Olof
