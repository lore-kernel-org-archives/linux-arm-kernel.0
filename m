From: balbi@ti.com (Felipe Balbi)
Date: Mon, 19 Aug 2013 15:10:05 -0500
Subject: [PATCH RESEND] i2c: move of helpers into the core
In-Reply-To: <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20130819201005.GM26587@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
> I2C of helpers used to live in of_i2c.c but experience (from SPI) shows
> that it is much cleaner to have this in the core. This also removes a
> circular dependency between the helpers and the core, and so we can
> finally register child nodes in the core instead of doing this manually
> in each driver. So, fix the drivers and documentation, too.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

for i2c-omap.c:

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/322ff7dc/attachment.sig>
