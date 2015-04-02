From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Apr 2015 23:23:16 +0000
Subject: [PATCH 4/5] irqchip: armada-370-xp: Allow using wakeup source
In-Reply-To: <1427724278-12379-5-git-send-email-gregory.clement@free-electrons.com>
References: <1427724278-12379-1-git-send-email-gregory.clement@free-electrons.com>
 <1427724278-12379-5-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150402232316.GJ24598@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 30, 2015 at 04:04:37PM +0200, Gregory CLEMENT wrote:
> On the Armada 370/XP SoCs, in standby mode the SoC stay powered and it
> is possible to wake-up from any interrupt sources. This patch adds
> flag to the MPIC irqchip driver to let linux know this.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/irqchip/irq-armada-370-xp.c | 1 +
>  1 file changed, 1 insertion(+)

Applied to irqchip/mvebu

thx,

Jason.
