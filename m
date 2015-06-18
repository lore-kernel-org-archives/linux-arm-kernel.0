From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 16:52:23 +0200
Subject: [PATCH v2 0/2] mfd: flexcom: add a driver for Flexcom
In-Reply-To: <cover.1434632230.git.cyrille.pitchen@atmel.com>
References: <cover.1434632230.git.cyrille.pitchen@atmel.com>
Message-ID: <20150618145223.GJ27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/06/2015 at 15:05:08 +0200, Cyrille Pitchen wrote :
> ChangeLog
> 
> v2:
> - enhance the documentation of DT bindings and change the way the "ranges"
>   property is used.
> - replace __raw_readl() and __raw_writel() by readl() and writel().
> - change the module license to "GPL" for v2 or later
> - print the selected flexcom mode after the hardware version
> 
> v1:
> This series of patches a support to the Atmel Flexcom, a wrapper which
> integrates an USART, a SPI controller and a TWI controller. Only one
> peripheral can be used at a time. The active function is selected though
> the Flexcom Mode Register.
> 

For the whole set:
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
