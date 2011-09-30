From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 30 Sep 2011 02:17:59 -0600 (MDT)
Subject: [PATCH v5 1/3] AM35x: Using OMAP3 generic hwmods
In-Reply-To: <1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
	<1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
Message-ID: <alpine.DEB.2.00.1109300217260.12185@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abhilash,

On Fri, 30 Sep 2011, Abhilash K V wrote:

> From: Abhilash K V <abhilash.kv@ti.com>
> 
> Removing modules iva, sr1_hwmod, sr2_hwmod, mailbox from
> the base omap3xxx_hwmods list, so that they can be excluded
> for am35x.
> 
> Signed-off-by: Abhilash K V <abhilash.kv@ti.com>

Looks good to me, provisionally queued for 3.2 fixes.


- Paul
