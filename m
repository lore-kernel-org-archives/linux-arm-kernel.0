From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Jun 2015 18:39:47 +0200
Subject: [PATCH linux-next v2 2/4] tty/serial: at91: fix some macro
 definitions to fit coding style
In-Reply-To: <f22220ee42ecf9301def7e90154b74937ca9ffab.1434038494.git.cyrille.pitchen@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
 <f22220ee42ecf9301def7e90154b74937ca9ffab.1434038494.git.cyrille.pitchen@atmel.com>
Message-ID: <20150618163947.GR27492@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2015 at 18:20:15 +0200, Cyrille Pitchen wrote :
> This patch updates macro definitions in atmel_serial.h to fit the
> 80 column rule.
> 
> Please note that some deprecated comments such as "[AT91SAM9261 only]"
> are removed as the corresponding bits also exist in some later chips.
> 
> The patch also fix macro definitions in atmel_serial.c to replace
> (port,v) by (port, v).
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
