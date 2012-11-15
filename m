From: balbi@ti.com (Felipe Balbi)
Date: Thu, 15 Nov 2012 22:45:26 +0200
Subject: [PATCH] ARM: OMAP2+: Fix compiler warning for 32k timer
In-Reply-To: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
References: <1353008644-24745-1-git-send-email-jon-hunter@ti.com>
Message-ID: <20121115204526.GC12466@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 15, 2012 at 01:44:04PM -0600, Jon Hunter wrote:
> +static struct of_device_id omap_counter_match[] __initdata = {

not directly related to $SUBJECT, but shouldn't this be static const
__initconst ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121115/ee3b61c2/attachment.sig>
