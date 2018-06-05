From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 05 Jun 2018 09:36:26 +0100
Subject: [PATCH v2]irqchip/irq-gic-v3:Avoid a waste of LPI resource
In-Reply-To: <8898674D84E3B24BA3A2D289B872026A69F31014@G01JPEXMBKW03>
References: <8898674D84E3B24BA3A2D289B872026A69F1300F@G01JPEXMBKW03>
 <86d0xhaucm.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F3004A@G01JPEXMBKW03>
 <31bede40-dbc5-0a88-d12c-5fc79ea02391@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F30297@G01JPEXMBKW03>
 <8898674D84E3B24BA3A2D289B872026A69F31014@G01JPEXMBKW03>
Message-ID: <86efhlaaut.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Jun 2018 00:58:47 +0100,
Zhang, Lei wrote:
> 
> Hi Marc
> 
> Please let me know is there any plan to push your patch to v4.18.

None at the moment.

We're in the merge window, and no new changes will get queued unless
they fix a regression. This patch needs thorough review and testing,
as it changes a fundamental aspect of the driver. Also, it is pretty
useless on its own, as no bus supported in mainline actually make use
of the new allocator.

Thanks,

	M.

-- 
Jazz is not dead, it just smell funny.
