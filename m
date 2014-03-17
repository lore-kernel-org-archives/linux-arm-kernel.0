From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 17 Mar 2014 12:24:05 +0200
Subject: [PATCH v15][ 1/3] video: Kconfig: fbdev: restore the broader
 selection of FB_IMX
In-Reply-To: <1394794553-14719-1-git-send-email-denis@eukrea.com>
References: <1394794553-14719-1-git-send-email-denis@eukrea.com>
Message-ID: <5326CD45.2010506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/03/14 12:55, Denis Carikli wrote:
> The following patch:
>   b359bb0 video: Kconfig: Allow more broad selection of the imxfb framebuffer driver.
> Was accidentally reverted by this one:
>   ed3b5f2 Merge branch '3.15/fb-reorder' into for-next
> 
> Signed-off-by: Denis Carikli <denis@eukrea.com>

Thanks. I've fixed it.

It was my merge mistake.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140317/52c7e205/attachment.sig>
