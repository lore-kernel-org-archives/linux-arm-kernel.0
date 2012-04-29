From: B29397@freescale.com (Chen Peter-B29397)
Date: Sun, 29 Apr 2012 08:26:46 +0000
Subject: [PATCH 05/11] MXS: Modify the ci13xxx_udc to avoid adding UDC
In-Reply-To: <1335237523-9053-6-git-send-email-marex@denx.de>
References: <1335099567-21056-1-git-send-email-marex@denx.de>
 <1335237523-9053-1-git-send-email-marex@denx.de>
 <1335237523-9053-6-git-send-email-marex@denx.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803B7BD8D@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Subject: [PATCH 05/11] MXS: Modify the ci13xxx_udc to avoid adding UDC
> 
> On the i.MX platform, we are adding the UDC ourselves from the PHY driver.
> This
> patch adds a flag into the ci13xxx_udc that avoids adding the UDC if set.
> 

You may need to add reviewers for is using cil3xxx_udc too.
