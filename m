From: balbi@ti.com (Felipe Balbi)
Date: Mon, 28 Apr 2014 13:39:22 -0500
Subject: [PATCH 3/5] arm: omap2: skip device build from platform code for
 dt.
In-Reply-To: <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
References: <1397651532-31456-1-git-send-email-sourav.poddar@ti.com>
 <1397651532-31456-4-git-send-email-sourav.poddar@ti.com>
 <alpine.DEB.2.02.1404281827410.14616@utopia.booyaka.com>
Message-ID: <20140428183922.GV30292@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 06:28:45PM +0000, Paul Walmsley wrote:
> On Wed, 16 Apr 2014, Sourav Poddar wrote:
> 
> > For SOCs with dt enabled, device should be build through device tree.
> > Prevent device build call from platform code, if device tree is
> > enabled.
> > 
> > Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
> 
> Isn't OMAP2+ only supporting DT device enumeration now?

At least OMAP3 still isn't Dt-only.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140428/8144bec6/attachment.sig>
