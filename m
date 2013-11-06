From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 6 Nov 2013 12:34:52 +0100 (CET)
Subject: [PATCH v3 1/9] irqchip: add DesignWare APB ICTL interrupt
 controller
In-Reply-To: <1383661723-17956-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1381235073-17134-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1383661723-17956-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.DEB.2.02.1311061233010.23353@ionos.tec.linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 5 Nov 2013, Sebastian Hesselbarth wrote:

> This adds an irqchip driver and corresponding devicetree binding for the
> secondary interrupt controllers based on Synopsys DesignWare IP dw_apb_ictl.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Jisheng Zhang <jszhang@marvell.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
