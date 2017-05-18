From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 18 May 2017 09:45:50 +0200
Subject: [PATCH v2 0/4] irqchip: armada-370-xp: remove IRQ_NOAUTOEN
 workaround
In-Reply-To: <20170227233540.GL11350@io.lakedaemon.net>
References: <1488211940-26489-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20170227233540.GL11350@io.lakedaemon.net>
Message-ID: <20170518094550.1c363593@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 27 Feb 2017 23:35:40 +0000, Jason Cooper wrote:

> >  drivers/irqchip/irq-armada-370-xp.c | 146 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 129 insertions(+), 17 deletions(-)  
> 
> Thanks for a great patch series!  I'll pick this up once -rc1 drops.

Seems like you forgot to take this when 4.11-rc1 was published. So I
will rebase on 4.12-rc1 and resend.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
