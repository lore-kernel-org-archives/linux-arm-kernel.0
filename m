From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 29 Jul 2014 04:25:37 +0200
Subject: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <20140729022536.GC4421@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jul 28, 2014 at 04:15:48PM -0500, Felipe Balbi wrote:
> here's another rebase of the original series moving INTC
> to drivers.
> 
> There aren't many changes, only some fixes here and there
> because of recent changes to irq_domain and irqchip.
> 
> I have also added a patch to enable INTC address space
> protection so that only privileged modes can access
> INTC's address space.
> 
> Patches tested on top of v3.17-rc7 with a beagle bone black,
> the only plataform I have which still uses INTC.
> 
> Tony, if you can run your PM test cases on your side, I'd
> be really glad.

Reviewed-By: Sebastian Reichel <sre@kernel.org>

for the whole series except of "drop ti,intc-size support",
which breaks the DT API.

I will give this a try on my N900 in the next days.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140729/765a4b58/attachment.sig>
