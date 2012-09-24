From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 24 Sep 2012 18:06:27 +0300
Subject: [PATCH v3 1/2] ARM: Remove bcmring NAND driver
In-Reply-To: <1348263626-3087-2-git-send-email-csd@broadcom.com>
References: <1348263626-3087-1-git-send-email-csd@broadcom.com>
 <1348263626-3087-2-git-send-email-csd@broadcom.com>
Message-ID: <1348499187.4880.66.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-09-21 at 14:40 -0700, Christian Daudt wrote:
> This driver is being removed as part of the cleanup of the bcmring
> SoC from mainline as it is no longer maintained.
> 
> Signed-off-by: Christian Daudt <csd@broadcom.com>
> Reviewed-by: Jiandong Zheng <jdzheng@broadcom.com>
> Acked-by: Will Deacon <will.deacon@arm.com>

Pushed this patch to l2-mtd.git. But if you decide to merge it via
Arnd's tree (probably better idea) - let me know, I'll drop it.

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120924/8db93cc8/attachment-0001.sig>
