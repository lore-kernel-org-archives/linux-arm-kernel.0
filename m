From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Jul 2014 16:19:34 -0500
Subject: [PATCH 00/35] arm: omap: move intc to drivers/irqchip/
In-Reply-To: <1406582183-696-1-git-send-email-balbi@ti.com>
References: <1406582183-696-1-git-send-email-balbi@ti.com>
Message-ID: <20140728211934.GK7667@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Mon, Jul 28, 2014 at 04:15:48PM -0500, Felipe Balbi wrote:
> Hi folks,
> 
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

meant v3.16-rc7

> the only plataform I have which still uses INTC.
> 
> Tony, if you can run your PM test cases on your side, I'd
> be really glad.

for convenience, a branch with all these patches on top of v3.16-rc7 is
available at [1]:

git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git omap-fix-intc

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140728/7482ad17/attachment.sig>
