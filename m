From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 28 Mar 2012 11:06:17 +0100
Subject: [V2 2/4] rtc: fix 88pm860x rtc irq enable callback
In-Reply-To: <20120327164759.ec04c62e.akpm@linux-foundation.org>
References: <1329997662-2931-1-git-send-email-jtzhou@marvell.com>
 <1331259874-26503-1-git-send-email-jtzhou@marvell.com>
 <20120327164759.ec04c62e.akpm@linux-foundation.org>
Message-ID: <20120328100617.GB3232@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 27, 2012 at 04:47:59PM -0700, Andrew Morton wrote:

> It's surprising that the driver has been in-tree for a year and nobody
> has noticed this bug.  This makes me wonder if the fix is wrong.

I rather suspect few of the boards that use this chip ever run mainline
and we're seeing the effects of Android's ICS release rolling out here -
it's using 3.0 as the default kernel which was the first version which
included this driver as standard.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120328/9915d3a0/attachment.sig>
