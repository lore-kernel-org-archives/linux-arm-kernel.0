From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 3 Mar 2015 16:55:35 +0000
Subject: [version 2]  amba uarts - arm type uarts fifo size provided by
 device tree
In-Reply-To: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
References: <1424290069-8760-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
Message-ID: <20150303165534.GB10239@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 18, 2015 at 08:07:47PM +0000, Jorge Ramirez-Ortiz wrote:
> [PATCH 1/2] Documentation: bindings: add optional fifo size property
> [PATCH 2/2] drivers/tty: pl011: read fifo size from OF if present [updated]
> 
> These patches aim at resolving an issue present on some of the amba pl011 uarts.
> 
> They were developed for the Hisilicon Hi6220 SoC where the fifo size on the
> uarts is 64 despite the amba revision having been set to 1. 

Are we certain that the FIFO length is the only difference between the
HI6220 PL011 and a regular PL011?

It may be worth adding a compatible string in addition, just in case.

Mark.
