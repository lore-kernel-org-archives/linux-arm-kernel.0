From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 18 Jun 2013 10:46:25 +0200
Subject: [PATCH 3/7] mfd: twl4030-irq: use irq_get_trigger_type() to get
 IRQ flags
In-Reply-To: <1371228049-27080-4-git-send-email-javier.martinez@collabora.co.uk>
References: <1371228049-27080-1-git-send-email-javier.martinez@collabora.co.uk>
 <1371228049-27080-4-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20130618084625.GC7161@zurbaran>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 06:40:45PM +0200, Javier Martinez Canillas wrote:
> Use irq_get_trigger_type() to get the IRQ trigger type flags
> instead calling irqd_get_trigger_type(irq_get_irq_data(irq))
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
