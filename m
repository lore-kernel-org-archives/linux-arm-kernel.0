From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 14 Nov 2013 07:58:30 +0100
Subject: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
In-Reply-To: <1384396537-3486-5-git-send-email-tony@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
Message-ID: <20131114065830.GA2738@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 06:35:33PM -0800, Tony Lindgren wrote:
> As we claim to support device tree for mach-omap2, we
> should have the necessary flags in the driver to make it
> usable.
> 
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c at vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Wolfram Sang <wsa@the-dreams.de>

It would have been helpful if the message "PATCH [0/x]" would have been
sent to the i2c-list also.

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131114/2a1363a3/attachment-0001.sig>
