From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 Dec 2010 02:29:36 +0100
Subject: [PATCH v2] USB: atmel_usba_udc: fix freeing irq in
	usba_udc_remove()
In-Reply-To: <1292349630-3610-1-git-send-email-nicolas.ferre@atmel.com>
References: <636999.52551.qm@web180309.mail.gq1.yahoo.com>
	<1292349630-3610-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20101215012936.GR19897@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19:00 Tue 14 Dec     , Nicolas Ferre wrote:
> From: Rob Emanuele <rje@crystalfontz.com>
> 
> Add a free_irq() call on vbus gpio when we remove udc so that the
> vbus irq is properly released.
> 
> Signed-off-by: Rob Emanuele <rje@crystalfontz.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
