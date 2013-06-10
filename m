From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 10:07:49 +0100
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
In-Reply-To: <51B27010.5060603@boundarydevices.com>
References: <1370642870-8051-1-git-send-email-festevam@gmail.com>
 <20130607222051.GD18614@n2100.arm.linux.org.uk>
 <CAOMZO5B_PY0p1vqEUiYA88uhzYaOjnr5o9nXeEgLkKpPxD1LRQ@mail.gmail.com>
 <51B27010.5060603@boundarydevices.com>
Message-ID: <20130610090749.GD31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 04:43:12PM -0700, Troy Kisky wrote:

> Using -EPROBE_DEFER seems like an abuse. Shouldn't it turn the clock
> back off before it returns anyway?

Yes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/f2a6b416/attachment.sig>
