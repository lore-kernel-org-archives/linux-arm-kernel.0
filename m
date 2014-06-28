From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Jun 2014 19:08:04 +0200
Subject: [PATCHv8 2/3] devicetree: Addition of the Altera SDRAM EDAC. Add
 the
In-Reply-To: <1403882819-24929-3-git-send-email-tthayer@altera.com>
References: <1403882819-24929-1-git-send-email-tthayer@altera.com>
 <1403882819-24929-3-git-send-email-tthayer@altera.com>
Message-ID: <20140628170804.GD23634@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram-edac.txt
> @@ -0,0 +1,15 @@
> +Altera SOCFPGA SDRAM Error Detection & Correction [EDAC]
> +
> +Required properties:
> +- compatible : should contain "altr,sdram-edac";
> +- reg : should contain the ECC register range in sdram

SDRAM for consistency.

Acked-by: Pavel Machek <pavel@denx.de>
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
