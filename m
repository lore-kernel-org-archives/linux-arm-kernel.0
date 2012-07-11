From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 11 Jul 2012 18:49:08 +0100
Subject: [PATCH v5 0/6] spi: s3c64xx: add support for device tree
In-Reply-To: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
References: <1342021265-11212-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <20120711174908.GP3938@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 09:10:59PM +0530, Thomas Abraham wrote:
> Changes since v4:
> - Includes the missing gpio request for slave select line gpio as suggested
>   by Mark Brown.

These looked OK (and have had quite a bit of review already so we're
probably at the stage where incremental fixes are better anyway) so I
tried to apply them but git am was really unhappy.  I tried applying on

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/misc.git spi-next

and -next.  Can you check what's going on here please?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120711/d1dc1806/attachment.sig>
