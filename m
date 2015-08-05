From: tony@atomide.com (Tony Lindgren)
Date: Wed, 5 Aug 2015 03:31:55 -0700
Subject: [PATCH 4/4] ARM: dts: AM4372: Add the wkup_m3_ipc node
In-Reply-To: <1437167284-25659-5-git-send-email-d-gerlach@ti.com>
References: <1437167284-25659-1-git-send-email-d-gerlach@ti.com>
 <1437167284-25659-5-git-send-email-d-gerlach@ti.com>
Message-ID: <20150805103155.GB16878@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [150717 14:10]:
> From: Suman Anna <s-anna@ti.com>
> 
> Add the Wakeup M3 IPC device node for the wkup_m3_ipc driver on
> AM4372 SoC. This node uses the IPC registers, part of the Control
> Module, and is therefore added as a child of the scm node.

Applying the last two patches in this series into omap-for-v4.3/dt
thanks.

Probably the send-no-irq quirk you can do in the driver based
on the compatible flag like I suggested in the related mailbox
thread so not applying those until that's been discussed.

Regards,

Tony
