From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 2 Aug 2018 10:11:21 +0200
Subject: [PATCH v11 6/6] tty/serial: atmel: change the driver to work
 under at91-usart mfd
In-Reply-To: <20180713164736.26028-7-radu.pirea@microchip.com>
References: <20180713164736.26028-1-radu.pirea@microchip.com>
 <20180713164736.26028-7-radu.pirea@microchip.com>
Message-ID: <20180802081121.GA26520@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 07:47:36PM +0300, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Acked-by: Richard Genoud <richard.genoud@gmail.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
