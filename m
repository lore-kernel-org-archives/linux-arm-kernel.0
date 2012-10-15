From: artem.bityutskiy@linux.intel.com (Artem Bityutskiy)
Date: Mon, 15 Oct 2012 16:55:39 +0300
Subject: [GIT PULL] OMAP-GPMC related cleanup for common zImage
In-Reply-To: <1350304405-14762-1-git-send-email-afzal@ti.com>
References: <1350303247-13495-1-git-send-email-afzal@ti.com>
 <1350304405-14762-1-git-send-email-afzal@ti.com>
Message-ID: <1350309339.5769.10.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2012-10-15 at 18:03 +0530, Afzal Mohammed wrote:
> The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:
> 
>   Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)
> 
> are available in the git repository at:
> 
>   git://gitorious.org/x0148406-public/linux-kernel.git tags/gpmc-czimage

FWIW, the mtd changes look OK, and this stuff is very OMAP-specific, so
merging everything through the OMAP tree makes a lot of sense. Thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121015/06e4839b/attachment.sig>
