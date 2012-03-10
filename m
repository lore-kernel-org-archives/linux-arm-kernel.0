From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Sat, 10 Mar 2012 15:02:38 +0400
Subject: [PATCH 5/7] USB: r8a66597-hcd: restore big-endian operation.
In-Reply-To: <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
References: <1331311133-26937-1-git-send-email-thomas@codesourcery.com>
 <1331311133-26937-5-git-send-email-thomas@codesourcery.com>
Message-ID: <4F5B34CE.5040900@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 09-03-2012 20:38, Thomas Schwinge wrote:

> On SH, as of 37b7a97884ba64bf7d403351ac2a9476ab4f1bba we have to use the

    Please also specify the summary of thta commit in parens.

> endianess-agnostic I/O accessor functions.

> This driver is also enabled in ARM's viper_defconfig as well as MIPS'
> bcm47xx_defconfig and fuloong2e_defconfig -- I suppose none of these are
> operating in big-endian mode, or this issue should already have been noticed
> before.

> The device is now recognized correctly for both litte-endian and big-endian
> sh7785lcr, but I have not tested this any further, as the board is situated in
> a remote data center.

> Signed-off-by: Thomas Schwinge<thomas@codesourcery.com>
> Cc: Paul Mundt<lethal@linux-sh.org>
> Cc: linux-sh at vger.kernel.org
> Cc: linux-usb at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mips at linux-mips.org

WBR, Sergei
