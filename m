From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 30 Oct 2012 14:42:21 +0000 (UTC)
Subject: [PATCH] ARM: OMAP2+: am33xx: Add PRM warm reset/reboot support
In-Reply-To: <1351504747-10554-1-git-send-email-hvaibhav@ti.com>
References: <1351504747-10554-1-git-send-email-hvaibhav@ti.com>
Message-ID: <alpine.DEB.2.00.1210301440250.12697@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Oct 2012, Vaibhav Hiremath wrote:

> This patch adds reboot capability to all AM33XX based boards/EVM's,
> by asserting PRM warm reset bit on 'reboot' command.
> 
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Tested-by: Daniel Mack <zonque@gmail.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Afzal Mohammed <afzal@ti.com>

Sounds like you're already planning to do this - but could you rebase this 
on the 3.8 PRCM cleanup branch that was sent in a separate mail?  

thanks,

- Paul
