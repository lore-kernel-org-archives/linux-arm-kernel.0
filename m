From: broonie@kernel.org (Mark Brown)
Date: Mon, 10 Jun 2013 10:10:00 +0100
Subject: [PATCH] ARM: mach-imx6q: Enable the codec clock earlier
In-Reply-To: <51B2717D.4080500@boundarydevices.com>
References: <1370642870-8051-1-git-send-email-festevam@gmail.com>
 <20130607222051.GD18614@n2100.arm.linux.org.uk>
 <CAOMZO5B_PY0p1vqEUiYA88uhzYaOjnr5o9nXeEgLkKpPxD1LRQ@mail.gmail.com>
 <51B27010.5060603@boundarydevices.com>
 <51B2717D.4080500@boundarydevices.com>
Message-ID: <20130610091000.GE31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 04:49:17PM -0700, Troy Kisky wrote:

> Sorry, I read that wrong.  Maybe sgtl5000 needs to get the clock, as
> well as imx-sgtl5000.

Yes, in general we should be able to use the clock API more but it's not
present on most platforms so it's hard to use in generic code like CODEC
drivers.  This is why I keep pushing to get the generic clock API
enabled on all platforms (which unfortunately nobody seems really
interested in).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130610/bb0fbb12/attachment.sig>
