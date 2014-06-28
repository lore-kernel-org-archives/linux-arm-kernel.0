From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 28 Jun 2014 19:07:53 +0200
Subject: [PATCHv8 1/3] devicetree: Addition of the Altera SDRAM Controller.
In-Reply-To: <1403882819-24929-2-git-send-email-tthayer@altera.com>
References: <1403882819-24929-1-git-send-email-tthayer@altera.com>
 <1403882819-24929-2-git-send-email-tthayer@altera.com>
Message-ID: <20140628170753.GC23634@xo-6d-61-c0.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> From: Thor Thayer <tthayer@altera.com>
> 
> Add the Altera SDRAM controller bindings and device tree changes to the Altera SoC project.
> 
> Signed-off-by: Thor Thayer <tthayer@altera.com>

> diff --git a/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> new file mode 100644
> index 0000000..5027026
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/altera/socfpga-sdram.txt
> @@ -0,0 +1,11 @@
> +Altera SOCFPGA SDRAM Controller
> +
> +Required properties:
> +- compatible : "altr,sdr-ctl";
> +- reg : Should contain 1 register ranges(address and length)

"1 register range ("

Otherwise:

Acked-by: Pavel Machek <pavel@denx.de>
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
