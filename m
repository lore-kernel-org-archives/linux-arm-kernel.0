From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 10 Mar 2015 09:02:47 +0100
Subject: [PATCH 1/4] dt-bindings: soc: Add documentation for the MediaTek
 SCPSYS unit
In-Reply-To: <7hegox6gri.fsf@deeprootsystems.com>
References: <1425888603-25800-1-git-send-email-s.hauer@pengutronix.de>
 <1425888603-25800-2-git-send-email-s.hauer@pengutronix.de>
 <7hegox6gri.fsf@deeprootsystems.com>
Message-ID: <20150310080246.GC24885@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 01:46:25PM -0700, Kevin Hilman wrote:
> Sascha Hauer <s.hauer@pengutronix.de> writes:
> 
> > This adds documentation for the MediaTek SCPSYS unit found in MT8173 SoCs.
> 
> Curious if this IP unique to the 8173?  or maybe also used on 8135? ...

This is indeed found on the MT8135 aswell, but I already spotted the
first differences, so we'll need the SoC specific compatible anyway.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
