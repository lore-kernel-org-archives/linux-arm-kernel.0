From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Mon, 26 Sep 2011 17:15:41 +0400
Subject: [RFC PATCH 10/14] ARM: cns3xxx: convert to
	CONFIG_MULTI_IRQ_HANDLER
In-Reply-To: <1316796692-15964-11-git-send-email-marc.zyngier@arm.com>
References: <1316796692-15964-1-git-send-email-marc.zyngier@arm.com>
	<1316796692-15964-11-git-send-email-marc.zyngier@arm.com>
Message-ID: <20110926131541.GA28254@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 23, 2011 at 05:51:28PM +0100, Marc Zyngier wrote:
> Convert the cns3xxx platform to be using the gic_handle_irq
> function as its primary interrupt handler.
> 
> Cc: Anton Vorontsov <avorontsov@mvista.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Anton Vorontsov <cbouatmailru@gmail.com>

Thanks!
