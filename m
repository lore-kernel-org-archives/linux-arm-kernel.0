From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 15 Jul 2012 18:12:13 -0600 (MDT)
Subject: [RFC 3/6] ARM: OMAP3: hwmod data: fix iva2 reset info
In-Reply-To: <1342197459-7920-4-git-send-email-t-kristo@ti.com>
References: <1342197459-7920-1-git-send-email-t-kristo@ti.com>
 <1342197459-7920-4-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1207151811380.28834@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 13 Jul 2012, Tero Kristo wrote:

> IVA2 hwmod resets were missing the status bit offsets. Also, as the
> hwmod itself didn't have prcm info at all, resetting iva hwmod was
> accessing some bogus memory addresses. Added both infos to fix this.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>

Thanks, this one looks like it's fodder for the -rc series due to the 
accesses, so, queuing for 3.6-rc.


- Paul
