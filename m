From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 22 Jul 2015 09:58:45 +0200 (CEST)
Subject: [PATCH 1/5] genirq: irqdomain: Use an accessor for the of_node
 field
In-Reply-To: <55AF4BBA.5030209@arm.com>
References: <1437473280-11431-1-git-send-email-marc.zyngier@arm.com>
 <1437473280-11431-2-git-send-email-marc.zyngier@arm.com>
 <55AF47D7.8010304@linaro.org> <55AF4BBA.5030209@arm.com>
Message-ID: <alpine.DEB.2.11.1507220958090.18576@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 Jul 2015, Marc Zyngier wrote:
> 
> Looks like my coccinelle foo is still lacking a bit... Oh well.

Please post your semantic patch and don't forget to Cc Julia Lawall :)
