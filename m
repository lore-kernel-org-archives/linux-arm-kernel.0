From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 21 May 2010 09:20:45 +0200
Subject: [PATCH 0/3] Driver for the i.MX2x CMOS Sensor Interface
In-Reply-To: <cover.1273150585.git.baruch@tkos.co.il>
References: <cover.1273150585.git.baruch@tkos.co.il>
Message-ID: <20100521072045.GD17272@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 06, 2010 at 04:09:38PM +0300, Baruch Siach wrote:
> This series contains a soc_camera driver for the i.MX25/i.MX27 CSI device, and 
> platform code for the i.MX25 and i.MX27 chips. This driver is based on a driver 
> for i.MX27 CSI from Sascha Hauer, that  Alan Carvalho de Assis has posted in 
> linux-media last December[1]. Since all I have is a i.MX25 PDK paltform I can't 
> test the mx27 specific code. Testers and comment are welcome.
> 
> [1] https://patchwork.kernel.org/patch/67636/
> 
> Baruch Siach (3):
>   mx2_camera: Add soc_camera support for i.MX25/i.MX27
>   mx27: add support for the CSI device
>   mx25: add support for the CSI device

With the two additions I sent I can confirm this working on i.MX27, so
no need to remove the related code.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
