From: broonie@kernel.org (Mark Brown)
Date: Mon, 18 Apr 2016 18:03:11 +0100
Subject: [PATCH 3/6] regulator: rk808: Make rk808 generic, rename
 rk808-regulator.c
In-Reply-To: <57148C05.4090900@phytec.de>
References: <1460711790-22646-1-git-send-email-w.egorov@phytec.de>
 <1460711790-22646-4-git-send-email-w.egorov@phytec.de>
 <20160415102602.GE3217@sirena.org.uk>
 <20160415162406.GD25196@piout.net> <57148C05.4090900@phytec.de>
Message-ID: <20160418170311.GK3217@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 18, 2016 at 09:25:57AM +0200, Wadim Egorov wrote:

> It seems this topic has been already discussed here [1].
> So the right solution is just to rename the rk808 struct in rk808.h,
> don't touch the driver names and config options and naming the
> additional RK818 PMIC in the Kconfig?

Something like that, yes.  If it's really useful for clarification some
renaming of code might be useful.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160418/9c7dbacf/attachment-0001.sig>
