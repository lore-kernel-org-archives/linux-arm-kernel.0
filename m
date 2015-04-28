From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Apr 2015 15:30:12 +0200
Subject: [PATCH v2] mtd: nand: pxa3xx: Switch FIFO draining to
 jiffies-based timeout
In-Reply-To: <1428413565-27644-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1428413565-27644-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150428133012.GF10950@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Brian,

On Tue, Apr 07, 2015 at 03:32:45PM +0200, Maxime Ripard wrote:
> Now that the driver handles the FIFO draining in a threaded interrupt, we can
> base our timeout on jiffies and sleeping, instead of using mdelay.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Ping?

You were the one that asked for this patch in the first place, so I
was kind of expecting you would merge it :)

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150428/f257d4a9/attachment-0001.sig>
