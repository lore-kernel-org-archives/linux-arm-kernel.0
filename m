From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jul 2015 21:34:39 +0100
Subject: [PATCH v2 06/13] irqchip: kill off set_irq_flags usage
In-Reply-To: <87pp3rj3uj.fsf@belgarion.home>
References: <1436711211-18223-1-git-send-email-robh@kernel.org>
 <1436711211-18223-7-git-send-email-robh@kernel.org>
 <alpine.DEB.2.11.1507121737030.20072@nanos>
 <20150716132632.GK7557@n2100.arm.linux.org.uk>
 <87pp3rj3uj.fsf@belgarion.home>
Message-ID: <20150716203439.GN7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 16, 2015 at 09:32:20PM +0200, Robert Jarzmik wrote:
> For PXA I must admit I don't yet know. I know lubbock has an UCB1400, but I
> don't have it working yet, so I can't foresee the problems yet.

The UCB1400 is an AC'97 device which is quite different from its
predecessors, and is not supported by the UCB1x00 driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
