From: tglx@linutronix.de (Thomas Gleixner)
Date: Tue, 11 Jun 2013 10:46:29 +0200 (CEST)
Subject: [PATCH v3 1/6] irqchip: add support for Marvell Orion SoCs
In-Reply-To: <1370536034-23956-2-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1370536034-23956-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1370536034-23956-2-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <alpine.LFD.2.02.1306111045520.22970@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Jun 2013, Sebastian Hesselbarth wrote:

> This patch adds an irqchip driver for the main interrupt controller found
> on Marvell Orion SoCs (Kirkwood, Dove, Orion5x, Discovery Innovation).
> Corresponding device tree documentation is also added.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
