From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Jan 2014 21:42:01 +0100
Subject: [PATCH 1/4] ARM: dts: cm-fx6: rearrange the dts file
In-Reply-To: <1390320812-25100-2-git-send-email-grinberg@compulab.co.il>
References: <1390320812-25100-1-git-send-email-grinberg@compulab.co.il>
 <1390320812-25100-2-git-send-email-grinberg@compulab.co.il>
Message-ID: <20140121204201.GX16215@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Igor,

On Tue, Jan 21, 2014 at 06:13:29PM +0200, Igor Grinberg wrote:
> Move the iomuxc definition before the devices definitions
> (e.g. gpmi, fec).

The nodes are sorted alphabetically. Please keep them sorted.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
