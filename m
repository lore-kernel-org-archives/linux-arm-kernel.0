From: pavel@denx.de (Pavel Machek)
Date: Fri, 4 Apr 2014 12:35:27 +0200
Subject: [PATCH] dt-bindings: add vendor-prefix for Newhaven Display
In-Reply-To: <1396493527-26170-1-git-send-email-dinguyen@altera.com>
References: <1396493527-26170-1-git-send-email-dinguyen@altera.com>
Message-ID: <20140404103527.GC9242@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2014-04-02 21:52:07, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Newhaven Display provides the worldwide marketplace with cost
> effective high quality display devices ranging from OLED and LCD
> Displays to VFD Displays.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>

Commit log should not be a place for advertising? :-)

Reviewed-by: Pavel Machek <pavel@denx.de>

> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 4685ec3..7037990 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -60,6 +60,7 @@ microchip	Microchip Technology Inc.
>  mosaixtech	Mosaix Technologies, Inc.
>  national	National Semiconductor
>  neonode		Neonode Inc.
> +newhaven	Newhaven Display International
>  nintendo	Nintendo
>  nvidia	NVIDIA
>  nxp	NXP Semiconductors

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
