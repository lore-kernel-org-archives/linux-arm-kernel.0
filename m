From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Mon, 14 Mar 2011 00:40:48 +0100
Subject: [PATCH V12 3/4] ptp: Added a clock driver for the IXP46x.
In-Reply-To: <cd6ddff0dcca60ac88b35660505d7bf54ad32405.1298878618.git.richard.cochran@omicron.at>
	(Richard Cochran's message of "Mon, 28 Feb 2011 08:58:27 +0100")
References: <cover.1298878618.git.richard.cochran@omicron.at>
	<cd6ddff0dcca60ac88b35660505d7bf54ad32405.1298878618.git.richard.cochran@omicron.at>
Message-ID: <m3ei6azj0f.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran <richardcochran@gmail.com> writes:

> This patch adds a driver for the hardware time stamping unit found on the
> IXP465. The basic clock operations and an external trigger are implemented.
>
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
> Acked-by: John Stultz <johnstul@us.ibm.com>
> ---
>  arch/arm/mach-ixp4xx/include/mach/ixp46x_ts.h |   78 ++++++
>  drivers/net/arm/ixp4xx_eth.c                  |  192 ++++++++++++++-
>  drivers/ptp/Kconfig                           |   13 +
>  drivers/ptp/Makefile                          |    1 +
>  drivers/ptp/ptp_ixp46x.c                      |  332 +++++++++++++++++++++++++

I can't see any obvious problem in this code, though I don't have IXP46x
hardware.

Acked-by: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa
