From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Apr 2016 11:26:02 +0100
Subject: [PATCH 3/6] regulator: rk808: Make rk808 generic, rename
 rk808-regulator.c
In-Reply-To: <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
 <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
Message-ID: <20160415102602.GE3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 15, 2016 at 11:16:27AM +0200, Wadim Egorov wrote:

> This patch just renames the rk808 driver so we can reuse this driver
> to add more regulator devices from the RK8XX PMIC family later.

We normally manage to cope fine without renaming things - it's quite
common to have drivers that were initially named after one part
supporting multiple parts, avoiding the rename makes things like
backports easier and avoids needing git log --follow and so on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160415/169ef42d/attachment.sig>
