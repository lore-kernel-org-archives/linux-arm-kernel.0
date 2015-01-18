From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 18 Jan 2015 23:02:10 +0100
Subject: [PATCHv3] media: i2c/adp1653: devicetree support for adp1653
In-Reply-To: <20150104094352.GA3790@amd>
References: <20141203214641.GA1390@amd> <20141224223434.GA20669@amd>
 <20150104094352.GA3790@amd>
Message-ID: <20150118220210.GA7481@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun 2015-01-04 10:43:52, Pavel Machek wrote:
> 
> We are moving to device tree support on OMAP3, but that currently
> breaks ADP1653 driver. This adds device tree support, plus required
> documentation.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Sakari? You are listed as adp1653 maintainer. Did you apply the patch?
Is it going to be in 3.20?

Thanks,
								Pavel
								
> ---
> 
> Please apply,
> 							Pavel
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adp1653.txt b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> new file mode 100644
> index 0000000..0fc28a9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/adp1653.txt
> @@ -0,0 +1,37 @@
> +* Analog Devices ADP1653 flash LED driver

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
